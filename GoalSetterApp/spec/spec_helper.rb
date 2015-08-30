
RSpec.configure do |config|

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
    # config.include TestHelper, :type => :feature

  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end
end

def login_user(user)
  visit(new_session_url)
  fill_in('Username', :with => 'my_name')
  fill_in('Password', :with => 'password')
  click_button('Sign In')
end
