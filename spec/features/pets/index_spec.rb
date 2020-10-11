require 'rails_helper'

describe "Pets Index" do
  before (:each) do
    @shelter_1 = Shelter.create!(
      name: "Will's Pet Shelter",
      address: "123 Main St",
      city: "Boulder",
      state: "CO",
      zip: "80309"
    )

    @shelter_2 = Shelter.create!(
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
      shelter: @shelter_2
    )
  end

  describe "When I visit /pets" do
    it "I see each pet and their info" do
      visit '/pets'

      expect(page).to have_xpath("//img[contains(@src,'#{@pet_1.image}')]")
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.age)
      expect(page).to have_content(@pet_1.sex)
      expect(page).to have_content(@pet_1.shelter.name)

      expect(page).to have_xpath("//img[contains(@src,'#{@pet_2.image}')]")
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_2.age)
      expect(page).to have_content(@pet_2.sex)
      expect(page).to have_content(@pet_2.shelter.name)
    end
  end
end
