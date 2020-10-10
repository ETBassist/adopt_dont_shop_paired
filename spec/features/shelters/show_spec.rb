require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/:id' do
    let(:shelter) { Shelter.create!(
      name: "Will's Pet Shelter",
      address: "123 Main St",
      city: "Boulder",
      state: "CO",
      zip: "80309"
    ) }

    it "I see the shelter's name, address, city, state, and zip" do
      visit "/shelters/#{shelter.id}"

      expect(page).to have_content(shelter.name)
      expect(page).to have_content(shelter.address)
      expect(page).to have_content(shelter.city)
      expect(page).to have_content(shelter.state)
      expect(page).to have_content(shelter.zip)
    end

    it 'I can delete the shelter' do
      visit "/shelters/#{shelter.id}"

      click_on 'Delete Shelter'

      expect(current_path).to eq('/shelters')
      expect(page).to_not have_content(shelter.name)
    end
  end
end
