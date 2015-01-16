require 'spec_helper'
require 'helpers/user_management.rb'

feature 'Posting a peep' do

  before(:each) do
    sign_up
    sign_in('josh@test.com', 'test')
    expect(page).to have_content('Welcome, Josh')
  end
  
  scenario 'A user has no peeps when they first sign up' do
    user = User.first
    expect(user.peeps.length).to eq 0
  end

end