require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters' do
    before (:each) do
      @shelter_1 = Shelter.create!(
        name: "Will's Pet Shelter",
        address: "123 Main St",
        city: "Boulder",
        state: "CO",
        zip: "80309"
      )

      @shelter_2 = Shelter.create(
        name: "Pet Rescue",
        address: "10 Normal Rd",
        city: "Denver",
        state: "CO",
        zip: "80249"
      )

      @pet_1 = Pet.create!(
        image: "https://placedog.net/280?id=1",
        name: "Max",
        age: "14",
        sex: "Female",
        description: "A nice doggo",
        adoptable: false,
        shelter: @shelter_1
      )

      @pet_2 = Pet.create!(
        image: "https://placedog.net/280?id=2",
        name: "Toby",
        age: "7",
        sex: "Male",
        description: "A nice doggo",
        adoptable: true,
        shelter: @shelter_1
      )

      @pet_3 = Pet.create!(
        image: "https://placedog.net/280?id=3",
        name: "Mojo",
        age: "11",
        sex: "Female",
        description: "A nice doggo",
        adoptable: true,
        shelter: @shelter_2
      )

      @pet_4 = Pet.create!(
        image: "https://placedog.net/280?id=4",
        name: "Harper",
        age: "5",
        sex: "Female",
        description: "A nice doggo",
        adoptable: true,
        shelter: @shelter_2
      )
    end
    it 'Then I see the name of each shelter in the system' do
      visit '/shelters'

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
    end

    it 'I can sort by number of adoptable pets' do
      visit '/shelters'

      expect(@shelter_1.name).to appear_before(@shelter_2.name)

      click_on 'Sort By: Number of Adoptable Pets'

      expect(@shelter_1.name).to_not appear_before(@shelter_2.name)
    end
  end
end
