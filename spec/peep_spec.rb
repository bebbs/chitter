require 'spec_helper'
require 'helpers/user_management.rb'

feature 'Posting a peep' do
  
  scenario 'A user has no peeps when they first sign up' do
    sign_up_and_in
    user = User.first
    expect(user.peeps.length).to eq 0
  end

  scenario 'A user can post a peep' do
    sign_up_and_in
    post_peep
    user = User.first
    expect(Peep.first.content).to eq 'Test first peep'
    expect(Peep.first.user_id).to eq user.id
  end

  scenario "Logged in users can't post peeps" do
    visit '/'
    expect(page).not_to have_content('Post a peep:')
  end
end

def post_peep
  visit '/'
  fill_in 'peep', with: 'Test first peep'
  click_button 'Post'
end

def sign_up_and_in
  sign_up
  sign_in('josh@test.com', 'test')
  expect(page).to have_content('Welcome, Josh')
end