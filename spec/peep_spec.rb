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

  scenario 'A user can post a peep' do
    user = User.first
    post_peep
    expect(Peep.first.content).to eq 'Test first peep'
    expect(Peep.first.user_id).to eq user.id
  end

end

def post_peep
  visit '/'
  fill_in 'peep', with: 'Test first peep'
  click_button 'Post'
end