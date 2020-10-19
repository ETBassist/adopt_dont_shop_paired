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

      within('.all-shelters') do
        expect(@shelter_1.name).to appear_before(@shelter_2.name)
      end

      click_on 'Sort By: Number of Adoptable Pets'

      within('.all-shelters') do
        expect(@shelter_1.name).to_not appear_before(@shelter_2.name)
      end
    end

    it 'I can sort by alphabetical order' do
      visit '/shelters'

      within('.all-shelters') do
        expect(@shelter_1.name).to appear_before(@shelter_2.name)
      end

      click_on 'Sort By: Alphabetical'

      within('.all-shelters') do
        expect(@shelter_1.name).to_not appear_before(@shelter_2.name)
      end
    end

    it 'I cannot delete a shelter if the pet has an approved app' do
      shelter = create(:shelter)
      pet = create(:pet, shelter: shelter)
      application = create(:application, status: 'Approved')
      pet_app = create(:pet_application, pet: pet, application: application)

      visit "/shelters"

      within("#shelter-#{shelter.id}") do
        expect(page).to_not have_link('Delete Shelter')
        expect(page).to have_content('Delete Shelter')
      end
    end

    it 'I see the top three highest rated shelters highlighted' do
      shelter_3 = create(:shelter)
      shelter_4 = create(:shelter)
      create(:review, shelter: @shelter_1, rating: 3)
      create(:review, shelter: @shelter_1, rating: 2)
      create(:review, shelter: @shelter_2, rating: 3)
      create(:review, shelter: @shelter_2, rating: 4)
      create(:review, shelter: shelter_3, rating: 5)
      create(:review, shelter: shelter_3, rating: 3)
      create(:review, shelter: shelter_4, rating: 3)
      create(:review, shelter: shelter_4, rating: 1)

      visit "/shelters"

      within(".best-shelters") do
        expect(shelter_3.name).to appear_before(@shelter_2.name)
        expect(@shelter_2.name).to appear_before(@shelter_1.name)
        expect(page).to_not have_content(shelter_4.name)
      end
    end
  end
end
