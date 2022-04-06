require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require 'yaml'
require 'pry'

before do
  @users = YAML.load_file("data/users.yaml")
end

helpers do
  def count_interests
    results = {}
    results[:users] = @users.keys.count
    interests = 0
    @users.each do |user, attr|
      interests += attr[:interests].count
    end
    results[:interests] = interests
    results
  end
end

get "/" do
  @title = "Users and Interests"
  erb :home
end

get "/users/:user" do
  @user = params[:user]
  @title = "#{@user.capitalize}'s page"
  @attr = @users[@user.to_sym]
  erb :user
end

not_found do
end
