class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  before_save :ensure_authentication_token
  def admin?
    self.role == "admin"
  end

  def self.get_facebook_user_data(access_token)
    conn = Faraday.new(:url => 'https://graph.facebook.com/me')
    response = conn.get "/me", { :access_token => access_token }
    data = JSON.parse(response.body)

    if response.status == 200
      data
    else
      Rails.logger.warn(data)
      nil
    end
  end

  def self.from_omniauth(auth)
    user = where( fb_uid: auth.uid ).first

    unless user
      user = self.new
      user.fb_uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end

    if auth.credentials
      user.fb_access_token = auth.credentials.token
      user.fb_expires_at = Time.at(auth.credentials.expires_at)
    end

    user.save
    user
  end

  # 從 Facebook 認證回來時，如果該 fb_uid 不存在
  # self.from_omniauth 會試圖直接新增 User
  # 如果新增失敗(例如有其他 validation 不過)，devise 就會導去註冊頁面
  # 而 self.new_with_session 這個方法提供註冊頁面的預設值
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def generate_authentication_token
    token = nil

    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end

    self.authentication_token = token
  end

  protected

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

end
