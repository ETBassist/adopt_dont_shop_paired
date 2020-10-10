require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/:id' do
    it 'I can update a shelter' do
      shelter = Shelter.create(
        name: "Pet Rescue",
        address: "10 Normal Rd",
        city: "Denver",
        state: "CO",
        zip: "80249"
      )

      visit "/shelters/#{shelter.id}"

      click_link 'Update Shelter'

      expect(current_path).to eq("/shelters/#{shelter.id}/edit")

      fill_in 'Name', with: 'Pet Haven'
      fill_in 'Address', with: '10 Normal Rd'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'CO'
      fill_in 'Zip', with: '80249'
      click_on 'Update Shelter'

      expect(current_path).to eq("/shelters/#{shelter.id}")
      expect(page).to have_content('Pet Haven')
    end
  end
end
