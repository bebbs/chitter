require 'sinatra/base'
require 'data_mapper'
require 'bcrypt'
require 'rack-flash'
require_relative '../lib/user.rb'

class Chitter < Sinatra::Base

  env = ENV['RACK_ENV'] || 'development'

  DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
  DataMapper.auto_upgrade!

  DataMapper.finalize

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    erb :index
  end

  get '/users/new' do
    erb :"users/new"
  end

  post '/users' do
    @user = User.create(email: params[:email],
                        username: params[:username],
                        display_name: params[:display_name],
                        password: params[:password])
    session[:user_id] = @user.id
    redirect '/'
  end

  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end

end