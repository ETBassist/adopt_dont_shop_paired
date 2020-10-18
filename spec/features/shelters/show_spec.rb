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

    it 'I cannot delete a shelter if there are any approved apps for pets' do
      shelter = create(:shelter)
      pet = create(:pet, shelter: shelter)
      application = create(:application, status: 'Approved')
      pet_app = create(:pet_application, pet: pet, application: application)

      visit "/shelters/#{shelter.id}"

      expect(page).to_not have_link('Delete Shelter')
      expect(page).to have_content('Delete Shelter')
    end

    it 'I can filter reviews by highest or lowest rating' do
      review1 = create(:review, shelter: @shelter, rating: 1, title: 'WTF')
      review2 = create(:review, shelter: @shelter, rating: 1, title: 'SRSLY ppl?')
      review3 = create(:review, shelter: @shelter, rating: 5, title: 'Wowza')
      review4 = create(:review, shelter: @shelter, rating: 2, title: 'Meh. Sure.')
      review5 = create(:review, shelter: @shelter, rating: 1, title: 'Run. Fast.')
      review6 = create(:review, shelter: @shelter, rating: 5, title: 'Love it.')

      visit "/shelters/#{@shelter.id}"

      expect(review1.title).to appear_before(review2.title)
      expect(review4.title).to appear_before(review5.title)
      expect(review5.title).to appear_before(review6.title)

      click_on 'Highest Rating'

      expect(review6.title).to appear_before(review3.title)
      expect(review3.title).to appear_before(review4.title)
      expect(review5.title).to appear_before(review1.title)

      click_on 'Lowest Rating'

      expect(review1.title).to appear_before(review2.title)
      expect(review2.title).to appear_before(review5.title)
      expect(review3.title).to appear_before(review6.title)

    end
  end
end
