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
      select "5", :from => "rating"
      fill_in :content, with: 'I adopted by bun bun through this shelter and they were so great.'
      fill_in :user_name, with: @user.name

      click_on 'Create Review'

      expect(current_path).to eq("/shelters/#{@shelter.id}")
      expect(page).to have_content('They are so great!')
      expect(page).to have_content('William Told')
    end

    it "I incorrectly fill in a new review" do
      visit "/shelters/#{@shelter.id}"

      click_link 'New Review'

      select "5", :from => "rating"
      fill_in :content, with: 'I adopted by bun bun through this shelter and they were so great.'
      fill_in :user_name, with: @user.name

      click_on 'Create Review'
      expect(page).to have_content('Please fill out all required fields')
    end

    it "will flash a message if the user doesn't exist" do
      visit "/shelters/#{@shelter.id}"

      click_link 'New Review'

      fill_in :title, with: 'They are so great!'
      select "5", :from => "rating"
      fill_in :content, with: 'I adopted by bun bun through this shelter and they were so great.'
      fill_in :user_name, with: "GobbleGobble"
      click_on 'Create Review'
      expect(page).to have_content('Failed to create review: User must exist')
    end

    it "The image will set to a default image if no image is given" do
      visit "/shelters/#{@shelter.id}"

      click_link 'New Review'

      fill_in :title, with: 'They are so great!'
      select "5", :from => "rating"
      fill_in :content, with: 'I adopted by bun bun through this shelter and they were so great.'
      fill_in :user_name, with: @user.name
      click_on 'Create Review'

      img = "https://cdn.iconscout.com/icon/premium/png-256-thumb/pet-117-805569.png"
      expect(page).to have_xpath("//img[contains(@src, '#{img}')]")
    end

    it "it will take me to edit a review if I have already reviewed this shelter" do
      review = Review.create(
        title: 'They are so great!',
        rating: 5,
        content: 'I adopted by bun bun through this shelter and they were so great.',
        shelter_id: @shelter.id,
        user_id: @user.id
      )
      visit "/shelters/#{@shelter.id}"

      click_link 'New Review'

      fill_in :title, with: 'They were so great!'
      select "3", :from => "rating"
      fill_in :content, with: 'I adopted by bun bun through this shelter and they were so great. Until recently, they have really gona downhill.'
      fill_in :user_name, with: @user.name
      click_on 'Create Review'

      expect(page).to have_content('You already have a review, want to update it?')
      expect(current_path).to eq("/reviews/#{review.id}/edit")
    end
  end
end
