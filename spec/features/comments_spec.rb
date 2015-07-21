
require 'spec_helper'
require 'rails_helper'

feature "commenting" do
  given!(:user){create :user}
  given!(:goal){create :goal}

  before(:each) do
    login_user(user)
    visit(goals_url)
  end

  it "can comment on a goal" do
    visit(goal_url(goal))
    expect(page).to have_content("Comment")
    page.should have_selector(:link_or_button, 'Add Comment')
  end

  it "can comment on a user" do
    visit(user_url(user))
    expect(page).to have_content("Comment")
    page.should have_selector(:link_or_button, 'Add Comment')
  end

  it "redirects to user show page" do
    visit(user_url(user))
    fill_in('Comment', with: "Whatever")
    click_on("Add Comment")
    current_path.should == user_url(user)
  end

  it "redirects to goal show page" do
    visit(goal_url(goal))
    fill_in('Comment', with: "Whatever")
    click_on("Add Comment")
    current_path.should == goal_url(goal)
  end

  it "requires comment body" do
    visit(goal_url(goal))
    fill_in('Comment', with: "")
    click_on("Add Comment")
    expect(page).to have_content("Content can't be blank")
  end

  feature "should display" do
    it "on a goal" do
      visit(goal_url(goal))
      fill_in('Comment', with: "Whatever")
      click_on("Add Comment")
      expect(page).to have_content("Whatever")
    end

    it "on a user" do
      visit(user_url(user))
      fill_in('Comment', with: "Whatever")
      click_on("Add Comment")
      expect(page).to have_content("Whatever")
    end

    it "properly displays comment author" do
      visit(goal_url(goal))
      fill_in('Comment', with: "Whatever")
      click_on("Add Comment")
      expect(page).to have_content("by #{user.username}")
    end
  end
end
