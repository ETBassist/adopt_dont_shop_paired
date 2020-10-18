require 'rails_helper'

describe "When I visit /shelter/:shelter_id/pets" do
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

    @pet_3 = Pet.create!(
      image: "https://placedog.net/280?id=3",
      name: "Mojo",
      age: "11",
      sex: "Female",
      description: "A nice doggo",
      adoptable: true,
      shelter: @shelter_1
    )
  end

  it "I see each pet in that shelter and their info" do
    visit "/shelters/#{@shelter_1.id}/pets"

    expect(page).to have_xpath("//img[contains(@src,'#{@pet_1.image}')]")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.age)
    expect(page).to have_content(@pet_1.sex)

    expect(page).to_not have_xpath("//img[contains(@src,'#{@pet_2.image}')]")
    expect(page).to_not have_content(@pet_2.name)
    expect(page).to_not have_content(@pet_2.age)
    expect(page).to_not have_content(@pet_2.sex)
  end

  it 'I can add a new pet' do
    visit "/shelters/#{@shelter_1.id}/pets"

    click_link 'Create Pet'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")

    fill_in 'Image', with: "https://placedog.net/280?id=1"
    fill_in 'Name', with: 'Roxie'
    fill_in 'Age', with: '14'
    fill_in 'Description', with: "A nice doggo"
    choose 'Male'
    click_on 'Create Pet'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
    expect(page).to have_content('Roxie')
  end

  it 'I see a count of pets' do
    visit "/shelters/#{@shelter_1.id}/pets"
    expect(page).to have_content('Total pets: 2')
  end

  it 'I see adoptable pets listed before pending' do
    visit "/shelters/#{@shelter_1.id}/pets"
    expect(@pet_3.name). to appear_before(@pet_1.name)
  end

  it 'I see filter by adoption status' do
    visit "/shelters/#{@shelter_1.id}/pets"

    click_link 'Adoptable Pets'

    expect(page).to have_content(@pet_3.name)
    expect(page).to_not have_content(@pet_1.name)

    click_link 'Pets Pending Adoption'

    expect(page).to_not have_content(@pet_3.name)
    expect(page).to have_content(@pet_1.name)
  end

  it 'I see section of pets with approved applications' do
    adopted_pet1 = create(:pet, shelter: @shelter_2, adoptable: false)
    adopted_pet2 = create(:pet, shelter: @shelter_2, adoptable: false)
    app_approved = create(:application, status: 'Approved')
    app_unapproved = create(:application, status: 'Pending')
    pet_app_approved = create(:pet_application, pet: adopted_pet1, application: app_approved)
    pet_app = create(:pet_application, pet: adopted_pet2, application: app_unapproved)

    visit "/shelters/#{@shelter_2.id}/pets"

    expect(page).to have_content('Adopted Pets')
    within('.adopted-pets') do
      expect(page).to have_content(adopted_pet1.name)
      expect(page).to_not have_content(adopted_pet2.name)
    end
  end
end
