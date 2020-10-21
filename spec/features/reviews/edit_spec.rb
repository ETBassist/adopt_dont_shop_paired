require 'rails_helper'

describe "As a visitor" do
  describe "when I visit the edit review path" do
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

    it "I see a form that includes the reviews pre-populated data" do
      visit "/reviews/#{@review.id}/edit"

      expect(page).to have_field(:title, with: @review.title)
      expect(page).to have_select(:rating, with_selected: @review.rating)
      expect(page).to have_field(:content, with: @review.content)
      expect(page).to have_field(:name, with: @user.name)
    end

    it "I can fill in the form and submit changes to a review" do
      visit "/reviews/#{@review.id}/edit"

      title = "I love my #{Faker::Creature::Dog.meme_phrase}"
      content = "#{Faker::Movies::HarryPotter.quote}"

      fill_in :title, with: title
      fill_in :content, with: content
      
      click_on("Update Review")
      expect(current_path).to eq("/shelters/#{@shelter.id}")

      expect(page).to have_content(title)
      expect(page).to have_content(content)
    end

    it "I incorrectly edited a review" do
      visit "/shelters/#{@shelter.id}"

      click_link 'Edit'

      fill_in :title, with: ''
      
      click_on 'Update Review'
      expect(page).to have_content('Please fill out all required fields')
    end

    it "will flash a message if the edited user doesn't exist" do
      visit "/shelters/#{@shelter.id}"

      click_link 'Edit'

      fill_in :user_name, with: "GobbleGobble"
      click_on 'Update Review'
      expect(page).to have_content('Failed to edit review: User must exist')
    end
  end
end
