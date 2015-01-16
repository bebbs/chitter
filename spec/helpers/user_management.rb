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