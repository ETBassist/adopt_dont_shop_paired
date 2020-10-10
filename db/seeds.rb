# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Shelter.create(
  name: "Will's Pet Shelter",
  address: "123 Main St",
  city: "Boulder",
  state: "CO",
  zip: "80309"
)

Shelter.create(
  name: "Pet Rescue",
  address: "10 Normal Rd",
  city: "Denver",
  state: "CO",
  zip: "80249"
)

Shelter.create(
  name: "Everywhere Pets!",
  address: "999 Simple Ln",
  city: "Fort Collins",
  state: "CO",
  zip: "80521"
)

Shelter.create(
  name: "Adopt-A-Pet",
  address: "321 Happy Ave",
  city: "Aurora",
  state: "CO",
  zip: "80011" 
)
