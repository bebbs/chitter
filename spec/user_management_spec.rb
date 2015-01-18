require 'spec_helper'
require 'helpers/user_management'

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

  scenario "With incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, Josh")
    sign_in('josh@test.com', 'wrong')
    expect(page).not_to have_content("Welcome, Josh")
  end

end

feature "Logging out" do
  
  before(:each) do
    User.create(email: 'josh@test.com',
                username: '@josh',
                display_name: 'Josh',
                password: 'test',
                password_confirmation: 'test')
  end

  scenario 'while being signed in' do
    sign_in('josh@test.com', 'test')
    click_button('Sign out')
    expect(page).to have_content('Goodbye')
    expect(page).not_to have_content('Welcome, Josh')
  end
end
