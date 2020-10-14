require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit a Users show page' do
    before :each do
      @user = User.create!(
        name: "William Told",
        street_address: "123 Main St",
        city: "Boulder",
        state: "CO",
        zip: "80309"
      ) 

      @shelter = Shelter.create!(
        name: "Will's Pet Shelter",
        address: "123 Main St",
        city: "Boulder",
        state: "CO",
        zip: "80309"
      )

      @review = @user.reviews.create!({
        title: "They are so great!",
        rating: 5,
        content: 'I adopted by bun bun through this shelter and they were so great.',
        shelter_id: @shelter.id
      } )
    end

    it "I see all that User's information" do
      visit "/users/#{@user.id}"

      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.street_address)
      expect(page).to have_content(@user.city)
      expect(page).to have_content(@user.state)
      expect(page).to have_content(@user.zip)
    end

    it "I see all the reviews for that User" do
      visit "/users/#{@user.id}"

      expect(page).to have_content(@review.title)
      expect(page).to have_content(@review.rating)
      expect(page).to have_content(@review.content)
    end

    it "I see an average of all review scored by that User" do
      review1 = create(:review, rating: 1, user: @user, shelter: @shelter)
      visit "/users/#{@user.id}"

      expect(page).to have_content('Average Review Score: 3')
    end
  end
end
