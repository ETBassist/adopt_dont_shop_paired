require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit a Users show page' do
    let(:user) { User.create!(
      name: "William Told",
      street_address: "123 Main St",
      city: "Boulder",
      state: "CO",
      zip: "80309"
    ) }

    it "I see all that User's information" do
      visit "/users/#{user.id}"

      expect(page).to have_content(user.name)
      expect(page).to have_content(user.street_address)
      expect(page).to have_content(user.city)
      expect(page).to have_content(user.state)
      expect(page).to have_content(user.zip)
    end
  end
end
