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

  it "I can change adoption status" do
    visit "/pets/#{pet.id}"

    click_on 'Change to Adoptable'
    expect(page).to have_content('Status: Adoptable')

    click_on 'Change to Pending Adoption'
    expect(page).to have_content('Status: Pending Adoption')
  end

  it 'I click a link to view all applications for this pet' do
    pet_app1 = create(:pet_application, pet: pet)
    pet_app2 = create(:pet_application, pet: pet)

    visit "/pets/#{pet.id}"

    expect(page).to_not have_link(pet_app1.application.user.name)
    expect(page).to_not have_link(pet_app2.application.user.name)

    click_link 'View all Applications'

    expect(page).to have_link(pet_app1.application.user.name)
    expect(page).to have_link(pet_app2.application.user.name)

    click_link "#{pet_app1.application.user.name}"

    expect(current_path).to eq("/applications/#{pet_app1.application.id}")
  end
end
