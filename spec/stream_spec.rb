require 'spec_helper'
require 'helpers/user_management'
require 'helpers/peep'

feature 'Viewing the stream of peeps' do

  before(:each) do
    sign_up
    post_peep('This is the first test peep')
    post_peep('This is the second test peep')
    post_peep('This is the third test peep')
  end

  scenario 'The homepage should display a list of peeps' do
    visit '/'
    expect(page).to have_content('This is the first test peep')
    expect(page).to have_content('This is the second test peep')
    expect(page).to have_content('This is the third test peep')
  end

  scenario 'Logged out users should be able to see the stream' do
    click_button('Sign out')
    expect(page).to have_content('This is the first test peep')
  end

  scenario 'The peeps should be displayed reverse chronologically' do
    visit '/'
    expect(page).to have_selector('ul.peeps li:nth-child(1)', text: 'This is the third test peep')
    expect(page).to have_selector('ul.peeps li:nth-child(2)', text: 'This is the second test peep')
    expect(page).to have_selector('ul.peeps li:nth-child(3)', text: 'This is the first test peep')
  end

  scenario 'Each tweet should display all of it\'s information' do
    visit '/'
    within 'ul.peeps li:nth-child(1)' do
      expect(page).to have_content('Posted by @josh')
    end
  end

end
