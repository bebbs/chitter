def post_peep(content)
  visit '/'
  fill_in 'peep', with: content
  click_button 'Post'
end