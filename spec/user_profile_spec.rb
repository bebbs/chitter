require 'spec_helper'
require 'helpers/user_management'
require 'helpers/peep'

feature 'Users should have a profile' do

  before(:each){sign_up
                post_peep('This is my first peep')
                post_peep('This is another peep')
                post_peep('This is yet another peep')}

  scenario 'No profile should be returned if the username doesn\'t exist' do
    visit '/profile/abc'
    expect(page).to have_content('This user cannot be found')
  end
  
  scenario 'Information about the user should be displayed' do
    visit '/profile/josh'
    within('.sidebar') do
      expect(page).to have_content('@josh')
      expect(page).to have_content('Josh')
    end
  end

  scenario 'All of a users peeps should be displayed' do
    visit '/profile/josh'
    expect(page).to have_content('This is my first peep')
    expect(page).to have_content('This is another peep')
    within('ul.peeps li:nth-child(1)') do
      expect(page).to have_content('Posted by @josh')
    end
  end

end