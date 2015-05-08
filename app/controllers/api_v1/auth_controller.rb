class ApiV1::AuthController < ApiController

  before_action :authenticate_user!, :only => :logout

  def login
    success = false

    if params[:email] && params[:password]
      user = User.find_by_email(params[:email])
      success = user && user.valid_password?(params[:password])
    elsif params[:access_token]
      # 用 Mobile devise 認證過的 FB access_token 再去問一次 facebook
      fb_data = User.get_facebook_user_data(params[:access_token])

      if fb_data
        auth_hash = OmniAuth::AuthHash.new({
          uid: fb_data["id"],
          info: {
            email: fb_data["email"]
          },
          credentials: {
            token: params[:access_token],
            expires_at: Time.now + 60.days
           }
        })
        user = User.from_omniauth(auth_hash)

      end

      success = fb_data && user.persisted?
    end

    if success
      render :json => { :message => "Ok",
                        :auth_token => user.authentication_token,
                        :user_name => user.name,
                        :user_email => user.email,
                        :user_id => user.id }
    else
      render :json => { :message => "Failed" }, :status => 401
    end
  end

  def logout
    current_user.generate_authentication_token
    current_user.save!

    render :json => { :message => "Ok" }
  end

end