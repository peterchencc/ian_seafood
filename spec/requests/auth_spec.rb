require 'rails_helper'

RSpec.describe "API_V1::Auth", :type => :request do

  before do
    @user = User.create!( :email => "ihower@gmail.com", :password => "12345678" )
  end

  example "login via email and password" do
    post "/api/v1/login", :email => "ihower@gmail.com", :password => "12345678"

    expect(response).to have_http_status(200)

    expect(response.body).to eq(
      {
        :message => "Ok",
        :user_token => @user.authentication_token,
        :user_id => @user.id
      }.to_json
    )
  end

  example "logout without login should get error" do
    post "/api/v1/logout"
    expect(response).to have_http_status(401)
  end

  example "logout and it should expire token" do
    token = @user.authentication_token

    post "/api/v1/logout", :user_email => @user.email, :user_token => token
    expect(response).to have_http_status(200)

    @user.reload

    expect(@user.authentication_token).not_to eq(token)
  end

  example "invalid login" do
    post "/api/v1/login", :email => "ihower@gmail.com", :password => "xx"

    expect(response).to have_http_status(401)

    expect(response.body).to eq(
      { :message => "Failed" }.to_json
    )
  end

end