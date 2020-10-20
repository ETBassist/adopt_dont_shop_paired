require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit the pet index page' do
    before (:each) do
      @user = create(:user)
      @shelter = create(:shelter)
      @pet = create(:pet, shelter: @shelter)
    end

    it 'I can create an application' do
      visit "/pets"

      click_on 'Start an Application'

      expect(current_path).to eq('/applications/new')
      expect(page).to have_content('Create New User')

      fill_in :user_name, with: @user.name

      click_on 'Submit'

      expect(current_path).to eq("/applications/#{@user.applications.last.id}")

      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.full_address)
      expect(page).to have_content("In Progress")
    end

    it "I get an error when I submit an application with a bad username" do
      visit "/pets"

      click_on 'Start an Application'

      expect(current_path).to eq('/applications/new')

      fill_in :user_name, with: 'Bob'

      click_on 'Submit'

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Invalid User Name")
    end

    it "I can find a user with a case insensitive search" do
      uppercase_name = @user.name.upcase
      visit '/applications/new'

      fill_in :user_name, with: uppercase_name

      click_button 'Submit'

      expect(current_path).to eq("/applications/#{@user.applications.last.id}")
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.full_address)
      expect(page).to have_content("In Progress")
    end
  end
end
