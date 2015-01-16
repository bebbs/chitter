require 'spec_helper'

feature 'User signs up' do
  
  scenario "When being a new user visiting the site" do
    expect{sign_up}.to change(User, :count).by 1
    expect(page).to have_content('Welcome, Josh')
    expect(User.first.username).to eq('@josh')
  end

  scenario "With a password that doesn't match" do
    expect{sign_up('a@a.com', '@josh', 'josh', 'test', 'wrong')}.to change(User, :count).by 0
    expect(current_path).to eq('/users')
    expect(page).to have_content("Password does not match the confirmation")
  end

  scenario "With an email that's already been registered" do
    expect{sign_up}.to change(User, :count).by 1
    expect{sign_up}.to change(User, :count).by 0
    expect(page).to have_content("Email is already taken")
  end

end

feature "Logging in" do

  before(:each) do
    User.create(email: 'josh@test.com',
                username: '@josh',
                display_name: 'Josh',
                password: 'test',
                password_confirmation: 'test')
  end

  scenario "With the correct credentials" do
    visit '/'
    expect(page).not_to have_content('Welcome, Josh')
    sign_in('josh@test.com', 'test')
    expect(page).to have_content('Welcome, Josh')
  end

end

def sign_up(email='josh@test.com', 
            username='@josh', 
            display_name='Josh', 
            password='test',
            password_confirmation='test')

  visit '/users/new'
  expect(page.status_code).to eq 200
  fill_in :email, with: email
  fill_in :username, with: username
  fill_in :display_name, with: display_name
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
end

def sign_in(email, password)
  visit 'sessions/new'
  fill_in 'email', with: email
  fill_in 'password', with: password
  click_button 'Sign in'
end
