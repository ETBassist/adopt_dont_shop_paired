require 'rails_helper'

describe "When I visit /pets" do
  it "I see each pet and their info" do
    shelter = Shelter.create!(
      name: "Will's Pet Shelter",
      address: "123 Main St",
      city: "Boulder",
      state: "CO",
      zip: "80309"
    )

    pet_1 = Pet.create!(
      image: "https://placedog.net/280?id=1",
      name: "Max",
      age: "14",
      sex: "Female",
      adoptable: false,
      shelter: shelter
    )

    pet_2 = Pet.create!(
      image: "https://placedog.net/280?id=2",
      name: "Toby",
      age: "7",
      sex: "Male",
      adoptable: true,
      shelter: shelter
    )

    visit '/pets'

    expect(page).to have_xpath("//img[contains(@src,'#{pet_1.image}')]")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content(pet_1.shelter.name)

  end
end
