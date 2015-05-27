class ApiV1::UsersController < ApiController

  before_action :set_user

  def index
  end

  def edit
  end

  def update

    if @user.update( user_params )

      render :json => { :message => "OK" }      
    else
      render :json => { :errors => @user.errors.full_messages }, :status => 400
    end
  
  end

  protected

  def user_params
    params.require(:user).permit(:name, :image, :email, :gender, :phone, :address, :birthday)
  end

  private

  def set_user
    @user = User.find( params[:id] )
  end

end
