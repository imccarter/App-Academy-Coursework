
require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit(new_user_url)
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
  end

  feature "signing up a user" do

    it "won't sign in if password is left blank" do
      visit(new_user_url)
      fill_in('Username', :with => 'My_name')
      click_button('Sign Up')
      expect(page).to have_content("Password is too short")
    end

    it "won't sign in if username is left blank" do
      visit(new_user_url)
      fill_in('Password', :with => 'asdf1234')
      click_button('Sign Up')
      expect(page).to have_content("Username can't be blank")
    end

    it "shows username on the homepage after signup" do
      visit(new_user_url)
      fill_in('Username', :with => 'My_name')
      fill_in('Password', :with => 'Seekrit')
      click_button('Sign Up')
      expect(page).to have_content('My_name')
    end
  end
end

feature "logging in" do
  given(:user){create :user}#Try build instead of create?

  it "shows username on the homepage after login" do
    login_user(user)
    expect(page).to have_content('my_name')
  end

end

feature "logging out" do
  before(:each) { create :user }
  it "begins with logged out state" do
    visit(root_url)
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Sign In")
    expect(page).not_to have_content("Sign Out")
  end

  it "doesn't show username on the homepage after logout" do
    visit(new_session_url)
    fill_in('Username', :with => 'my_name')
    fill_in('Password', :with => 'password')
    click_button('Sign In')
    click_on('Sign Out')
    expect(page).not_to have_content("my_name")
  end

end
