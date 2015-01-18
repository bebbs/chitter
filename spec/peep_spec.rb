require 'spec_helper'
require 'helpers/user_management'
<<<<<<< HEAD
require 'helpers/peep'
=======
require 'helpers/peeps'
>>>>>>> 27327070a94b0f4d31991591ed171f86d4cc0529

feature 'Posting a peep' do
  
  scenario 'A user has no peeps when they first sign up' do
    sign_up_and_in
    user = User.first
    expect(user.peeps.length).to eq 0
  end

  scenario 'A user can post a peep' do
    sign_up_and_in
    post_peep('Test first peep')
    user = User.first
    expect(Peep.first.content).to eq 'Test first peep'
    expect(Peep.first.user_id).to eq user.id
  end

  scenario "Logged in users can't post peeps" do
    visit '/'
    expect(page).not_to have_content('Post a peep:')
  end
end
