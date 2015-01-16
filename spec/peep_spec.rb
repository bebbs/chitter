require 'spec_helper'
require 'helpers/user_management.rb'

feature 'Posting a peep' do
  
  scenario 'When a logged in user' do
    sign_in('josh@test.com', 'test')
  end

end