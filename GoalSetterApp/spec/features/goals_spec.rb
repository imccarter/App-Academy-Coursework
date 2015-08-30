
require 'spec_helper'
require 'rails_helper'

feature "goals" do
  feature 'creating goals' do
    given(:user) {create :user}
    given(:other_user) {create :other_user}
    given!(:goal) {create :goal, user: other_user}
    given!(:my_goal) {create :my_goal, user: user}
    given!(:other_private_goal) {create :other_private_goal, user: other_user}
    given!(:my_private_goal) {create :my_private_goal, user: user}

    before(:each) do
      login_user(user)
      visit(goals_url)
    end

    it 'user can see public goals' do
      expect(page).to have_content('Goals')
      expect(page).to have_content('goal title')
    end

    it 'user can see the appropriate private goals' do
      expect(page).not_to have_content(other_private_goal.title)
      expect(page).to have_content(my_private_goal.title)
    end

    it 'user can create a goal' do
      click_on('New Goal')
      expect(page).to have_content('Title')
      expect(page).to have_content('Content')
      page.should have_selector(:link_or_button, 'Create Goal')
    end

    it "goal needs a title" do
      click_on('New Goal')
      fill_in('Content', :with => 'I will stop hunting kittens')
      click_button('Create Goal')
      expect(page).to have_content("Title can't be blank")
    end

    it "goal needs content" do
      click_on('New Goal')
      fill_in('Title', :with => 'I will stop hunting kittens')
      click_button('Create Goal')
      expect(page).to have_content("Content can't be blank")
    end


  end

  feature "goal show page" do

    given(:user) {create :user}

    before(:each) do
      login_user(user)
      visit(goals_url)
    end

    it "goal displays title and content" do
      click_on('New Goal')
      fill_in('Title', :with => 'Be a better person')
      fill_in('Content', :with => 'I will stop hunting kittens...tomorrow')
      choose('Public')
      click_button('Create Goal')
      expect(page).to have_content("I will stop hunting kittens...tomorrow")
      expect(page).to have_content("Be a better person")
      page.should have_selector(:link_or_button, 'Goals')
    end
  end

  feature "update goal" do

    given(:user) {create :user}
    given(:other_user) {create :other_user}
    given!(:goal) {create :goal, user: other_user}
    given!(:my_goal) {create :my_goal, user: user}
    given!(:other_private_goal) {create :other_private_goal, user: other_user}
    given!(:my_private_goal) {create :my_private_goal, user: user}

    before(:each) do
      login_user(user)
      visit(goals_url)
    end

    feature "should only let author edit goal" do
      it "won't let user edit a goal that they didn't write" do
        click_on('goal title')
        page.should_not have_selector(:link_or_button, 'Edit Goal')
      end

      it "will let user edit a goal that they did write" do
        click_on('my title')
        page.should have_selector(:link_or_button, 'Edit Goal')
      end
    end

    it "Edit Goal should bring you to the edit form" do
      save_and_open_page
      click_on('my title')
      click_on("Edit Goal")
      expect(page).to have_content("Title")
      expect(page).to have_content("Content")
      page.should have_selector(:link_or_button, "Update Goal")
    end

    it "Update Goal should change the title" do
      click_on('my title')
      click_on("Edit Goal")
      fill_in('Title', with: "Updated Goal Title")
      click_on("Update Goal")
      expect(page).to have_content('Updated Goal Title')
    end

    it "Update Goal should change the content" do
      click_on('my title')
      click_on("Edit Goal")
      fill_in('Content', with: "Updated content")
      click_on("Update Goal")
      expect(page).to have_content('Updated content')
    end
  end

  feature 'Removing goals' do

    given(:user) {create :user}
    given(:other_user) {create :other_user}
    given!(:goal) {create :goal, user: other_user}
    given!(:my_goal) {create :my_goal, user: user}
    given!(:other_private_goal) {create :other_private_goal, user: other_user}
    given!(:my_private_goal) {create :my_private_goal, user: user}

    before(:each) do
      login_user(user)
      visit(goals_url)
    end

    it "displays a button next on your own goals to delete them" do
      click_on("my title")
      page.should have_selector(:link_or_button, 'Remove Goal')
    end

    it "doesn't display the remove button for other's goals" do
      click_on("goal title")
      page.should_not have_selector(:link_or_button, 'Remove Goal')
    end

    it "redirects to the goal index after removal" do
      click_on("my title")
      click_on("Remove Goal")
      expect(page).to have_content("Goals")
    end

    it "removes the goal" do
      click_on("my title")
      click_on("Remove Goal")
      expect(page).not_to have_content("my title")
    end
  end

end
