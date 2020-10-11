require 'rails_helper'

describe "When I visit pets/:id" do

  let(:shelter) { Shelter.create!(
    name: "Will's Pet Shelter",
    address: "123 Main St",
    city: "Boulder",
    state: "CO",
    zip: "80309"
  ) }

  let(:pet) { Pet.create!(
    image: "https://placedog.net/280?id=1",
    name: "Max",
    age: "14",
    sex: "Female",
    description: "A nice doggo",
    adoptable: false,
    shelter: shelter
  ) }

  it "I see the pet image, name, description, age, sex, status" do
    visit "/pets/#{pet.id}"

    expect(page).to have_xpath("//img[contains(@src,'#{pet.image}')]")
    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet.description)
    expect(page).to have_content(pet.age)
    expect(page).to have_content(pet.sex)
    expect(page).to have_content(pet.status)
  end

  it "I can delete the pet" do
    visit "/pets/#{pet.id}"

    click_on 'Delete Pet'

    expect(current_path).to eq('/pets')
    expect(page).to_not have_content(pet.name)
  end
end
