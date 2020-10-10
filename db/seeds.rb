# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Shelter.destroy_all

shelter_1 = Shelter.create!(
  name: "Will's Pet Shelter",
  address: "123 Main St",
  city: "Boulder",
  state: "CO",
  zip: "80309"
)

shelter_2 = Shelter.create!(
  name: "Pet Rescue",
  address: "10 Normal Rd",
  city: "Denver",
  state: "CO",
  zip: "80249"
)

shelter_3 = Shelter.create!(
  name: "Everywhere Pets!",
  address: "999 Simple Ln",
  city: "Fort Collins",
  state: "CO",
  zip: "80521"
)

shelter_4 = Shelter.create!(
  name: "Adopt-A-Pet",
  address: "321 Happy Ave",
  city: "Aurora",
  state: "CO",
  zip: "80011"
)

pet_1 = Pet.create!(
  image: "https://placedog.net/280?id=1",
  name: "Max",
  age: "14",
  sex: "Female",
  adoptable: false,
  shelter: shelter_1
)

pet_2 = Pet.create!(
  image: "https://placedog.net/280?id=2",
  name: "Toby",
  age: "7",
  sex: "Male",
  adoptable: true,
  shelter: shelter_1
)

pet_3 = Pet.create!(
  image: "https://placedog.net/280?id=3",
  name: "Mojo",
  age: "11",
  sex: "Female",
  adoptable: true,
  shelter: shelter_2
)

pet_4 = Pet.create!(
  image: "https://placedog.net/280?id=4",
  name: "Harper",
  age: "5",
  sex: "Female",
  adoptable: true,
  shelter: shelter_2
)

pet_5 = Pet.create!(
  image: "https://placedog.net/280?id=5",
  name: "Fido",
  age: "2",
  sex: "Male",
  adoptable: true,
  shelter: shelter_3
)

pet_6 = Pet.create!(
  image: "https://placedog.net/280?id=6",
  name: "Eli",
  age: "9",
  sex: "Male",
  adoptable: false,
  shelter: shelter_4
)
