require 'spec_helper'
require 'helpers/user_management'
require 'helpers/peep'

feature 'Users should have a profile' do

  before(:each){ sign_up}
  
  scenario 'Information about the user should be displayed' do
    visit '/profile/josh'
    within('.sidebar') do
      expect(page).to have_content('@josh')
      expect(page).to have_content('Josh')
    end
  end

end