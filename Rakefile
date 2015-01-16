require 'data_mapper'
require './app/server.rb'

task :auto_upgrade do
  DataMapper.auto_upgrade!
  puts "Auto-upgrade (no data loss)"
end

task :auto_migrate do
  DataMapper.auto_migrate!
  puts "Auto-migrate (data was lost)"
end