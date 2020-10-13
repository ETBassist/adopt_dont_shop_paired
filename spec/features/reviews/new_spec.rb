require 'rails_helper'

describe 'As a visitor' do
  before(:each) do
    @shelter = Shelter.create!(
      name: "Will's Pet Shelter",
      address: "123 Main St",
      city: "Boulder",
      state: "CO",
      zip: "80309"
    )

    @user = User.create!(
      name: "William Told",
      street_address: "123 Main St",
      city: "Boulder",
      state: "CO",
      zip: "80309"
    )
  end
  describe 'When I visit shelter show page' do
    it 'I can create a new review' do
      visit "/shelters/#{@shelter.id}"

      click_link 'New Review'

      expect(current_path).to eq("/reviews/new")

      fill_in :title, with: 'They are so great!'
      fill_in :rating, with: 5
      fill_in :content, with: 'I adopted by bun bun through this shelter and they were so great.'
      fill_in :user_name, with: @user.name

      click_on 'Create Review'

      expect(current_path).to eq("/shelters/#{@shelter.id}")
      expect(page).to have_content('They are so great!')
      expect(page).to have_content('William Told')
    end
  end
end
