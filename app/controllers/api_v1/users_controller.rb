class ApiV1::UsersController < ApiController

  def index
    @user = User.find( params[:user_id] )
  end

end
