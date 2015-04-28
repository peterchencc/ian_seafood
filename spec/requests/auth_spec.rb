require 'rails_helper'

RSpec.describe "API_V1::Auth", :type => :request do

  before do
    @user = User.create!( :email => "ihower@gmail.com", :password => "12345678", :fb_uid => "168" )
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

  example "login via facebook access_token (existing user)" do
    fb_data  ={"id"=>"168", "email"=>"ihower@gmail.com", "name"=>"張文鈿" }
    expect(User).to receive(:get_facebook_user_data).with("fb-access-token-XXX").and_return(fb_data)

    post "/api/v1/login", :access_token => "fb-access-token-XXX"

    expect(response).to have_http_status(200)

    user = User.last
    expect(response.body).to eq(
      {
        :message => "Ok",
        :user_token => @user.authentication_token,
        :user_id => @user.id
      }.to_json
    )
  end

  example "login via facebook access_token (non-existing user)" do
    fb_data  ={"id"=>"999", "email"=>"ihover@gmail.com", "name"=>"張蚊鈿" }
    expect(User).to receive(:get_facebook_user_data).with("fb-access-token-XXX").and_return(fb_data)

    post "/api/v1/login", :access_token => "fb-access-token-XXX"

    expect(response).to have_http_status(200)

    user = User.last
    expect(response.body).to eq(
      {
        :message => "Ok",
        :user_token => user.authentication_token,
        :user_id => user.id
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
    post "/api/v1/login"

    expect(response).to have_http_status(401)

    expect(response.body).to eq(
      { :message => "Failed" }.to_json
    )
  end

  example "invalid login via user and password" do
    post "/api/v1/login", :email => "ihower@gmail.com", :password => "xx"

    expect(response).to have_http_status(401)

    expect(response.body).to eq(
      { :message => "Failed" }.to_json
    )
  end

  example "invalid login via facebook" do
    expect(User).to receive(:get_facebook_user_data).with("fb-access-token-XXX").and_return(nil)

    post "/api/v1/login", :access_token => "fb-access-token-XXX"

    expect(response).to have_http_status(401)

    expect(response.body).to eq(
      { :message => "Failed" }.to_json
    )
  end

end