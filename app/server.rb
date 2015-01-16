require 'sinatra/base'
require 'data_mapper'
require_relative '../lib/user'

class Chitter < Sinatra::Base

  env = ENV['RACK_ENV'] || 'development'

  DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
  DataMapper.auto_upgrade!

  DataMapper.finalize

  get '/' do
    'Hello, world!'
  end

end