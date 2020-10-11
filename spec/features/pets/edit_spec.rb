require 'rails_helper'

RSpec.describe "When I visit the pets show page" do
  before(:each) do
    @shelter_1 = Shelter.create!(
      name: "Will's Pet Shelter",
      address: "123 Main St",
      city: "Boulder",
      state: "CO",
      zip: "80309"
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
  end

  it "I can edit the pet" do
    visit "/pets/#{@pet_1.id}"

    click_link 'Update Pet'

    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")

    fill_in 'Image', with: "https://placedog.net/280?id=1"
    fill_in 'Name', with: 'Roxie'
    fill_in 'Age', with: '14'
    fill_in 'Description', with: "A nice doggo"
    choose 'Female'
    click_on 'Update Pet'

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content('Roxie')
  end
end
