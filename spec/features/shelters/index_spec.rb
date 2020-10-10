require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters' do
    it 'Then I see the name of each shelter in the system' do
      shelter_1 = Shelter.create!(
        name: "Will's Pet Shelter",
        address: "123 Main St",
        city: "Boulder",
        state: "CO",
        zip: "80309"
      )
      shelter_2 = Shelter.create(
        name: "Pet Rescue",
        address: "10 Normal Rd",
        city: "Denver",
        state: "CO",
        zip: "80249"
      )

      visit '/shelters'

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
    end
  end
end
