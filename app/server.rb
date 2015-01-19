require 'sinatra/base'
require 'data_mapper'
require 'bcrypt'
require 'rack-flash'
require_relative '../lib/user.rb'
require_relative '../lib/peep.rb'

class Chitter < Sinatra::Base

  env = ENV['RACK_ENV'] || 'development'

  DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
  DataMapper.finalize
  DataMapper.auto_upgrade!

  use Rack::Flash
  use Rack::MethodOverride

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    has_peeps? ? @peeps = Peep.all.reverse : nil
    erb :index
  end

  get '/users/new' do
    @user = User.new
    erb :"users/new"
  end

  post '/users' do
    @user = User.new(email: params[:email],
                     username: '@' + params[:username],
                     display_name: params[:display_name],
                     password: params[:password],
                     password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :"/users/new"
    end
  end

  get '/sessions/new' do
    erb :"/sessions/new"
  end

  post '/sessions' do
    email, password = params[:email], params[:password]
    user = User.authenticate(email, password)
    if user
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:errors] = ["The email or password is incorrect"]
      erb :"/sessions/new"
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    redirect '/'
  end

  post '/peep' do
    peep = Peep.new(content: params[:peep], user_id: current_user.id, created_at: Time.now)
    if peep.save
      redirect '/'
    else
      flash[:notice] = 'There was a problem posting your peep - please try again'
    end
  end

  get '/profile/:user_name' do
    if find_by_username(params[:user_name])
      @user = find_by_username(params[:user_name])
      @peeps = @user.peeps if has_peeps?
      erb :profile
    else
      flash[:notice] = 'This user cannot be found'
    end
  end

  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end

  def has_peeps?
    Peep.all.length > 0
  end

  def find_by_username(username)
    User.find{|user| user.username == ('@' + username)}
  end

end