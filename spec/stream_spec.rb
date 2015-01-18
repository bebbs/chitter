require 'spec_helper'
require 'helpers/user_management'
require 'helpers/peep'

feature 'Viewing the stream' do

  before(:each) do
    sign_up_and_in
    post_peep('This is the first peep')
    post_peep('This is the second peep')
    post_peep('This is the third peep')
  end
  
  scenario 'The homepage has a stream of tweets' do
    
  end

end