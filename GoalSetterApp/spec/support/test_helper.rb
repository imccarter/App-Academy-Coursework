module TestHelper
  def login_user(user)
    visit(new_session_url)
    fill_in('Username', :with => 'my_name')
    fill_in('Password', :with => 'password')
    click_button('Sign In')
  end
end
#
# RSpec.configure do |config|
#   config.include TestHelper, :type => :feature
# end
