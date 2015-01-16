require 'spec_helper'

feature 'User signs up' do
  
  scenario "When being a new user visiting the site" do
    expect{sign_up}.to change(User, :count).by 1
    expect(page).to have_content('Welcome, josh')
    expect(User.first.username).to eq('@josh')
  end

end 