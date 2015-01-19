require 'spec_helper'
require 'helpers/user_management'
require 'helpers/peep'

feature 'Posting a peep' do
  
  scenario 'A user has no peeps when they first sign up' do
    sign_up
    user = User.first
    expect(user.peeps.length).to eq 0
  end

  scenario 'A user can post a peep' do
    sign_up
    sign_in('josh@test.com', 'test')
    post_peep('Test first peep')
    user = User.first
    expect(Peep.first.content).to eq 'Test first peep'
    expect(Peep.first.user_id).to eq user.id
  end

  scenario "Non-logged in users can't post peeps" do
    visit '/'
    expect(page).not_to have_content('Post a peep:')
    expect(page).to have_content('Log in to post peeps!')
  end
end
