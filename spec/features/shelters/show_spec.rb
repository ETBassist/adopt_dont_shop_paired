require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/:id' do
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

      @review = Review.create!(
        title: 'They are so great!',
        rating: 5,
        content: 'I adopted by bun bun through this shelter and they were so great.',
        user: @user,
        shelter: @shelter
      )
    end

    it "I see the shelter's name, address, city, state, and zip" do
      visit "/shelters/#{@shelter.id}"

      expect(page).to have_content(@shelter.name)
      expect(page).to have_content(@shelter.address)
      expect(page).to have_content(@shelter.city)
      expect(page).to have_content(@shelter.state)
      expect(page).to have_content(@shelter.zip)
    end

    it 'I see a list of reviews for that shelter' do
      visit "/shelters/#{@shelter.id}"

      expect(page).to have_content(@review.title)
      expect(page).to have_content(@review.rating)
      expect(page).to have_content(@review.content)
      expect(page).to have_content(@review.user.name)
      expect(page).to have_link('New Review')
      expect(page).to have_link('Edit')
      expect(page).to have_link('Delete Review')
    end

    it 'I can delete the shelter' do
      visit "/shelters/#{@shelter.id}"

      click_on 'Delete Shelter'

      expect(current_path).to eq('/shelters')
      expect(page).to_not have_content(@shelter.name)
    end

    it 'I can delete a review' do
      visit "/shelters/#{@shelter.id}"

      click_on 'Delete Review'

      expect(current_path).to eq("/shelters/#{@shelter.id}")
      expect(page).to_not have_content(@review.title)
      expect(page).to_not have_content(@review.rating)
      expect(page).to_not have_content(@review.content)
      expect(page).to_not have_content(@review.user.name)
    end

    it 'I can see shelter statistics' do
      visit "/shelters/#{@shelter.id}"

      expect(page).to have_content("Total Pets: #{@shelter.pet_count}")
      expect(page).to have_content("Average Rating: #{@shelter.average_rating.round(2)}")
      expect(page).to have_content("Total Applications: #{@shelter.application_count}")
    end
  end
end
