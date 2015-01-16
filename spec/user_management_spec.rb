require 'spec_helper'

feature 'User signs up' do
  
  scenario "When being a new user visiting the site" do
    expect{sign_up}.to change(User, :count).by 1
    expect(page).to have_content('Welcome, Josh')
    expect(User.first.username).to eq('@josh')
  end

  def sign_up(email='josh@test.com', 
              username='@josh', 
              display_name='Josh', 
              password='test')

    visit '/users/new'
    expect(page.status_code).to eq 200
    fill_in :email, with: email
    fill_in :username, with: username
    fill_in :display_name, with: display_name
    fill_in :password, with: password
    click_button 'Sign up'
  end

end