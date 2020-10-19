# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Shelter.destroy_all
User.destroy_all
Application.destroy_all
Review.destroy_all
PetApplication.destroy_all

# shelter, no reviews, no pets
FactoryBot.create(:shelter)

# shelter, no reviews, with adoptable pets
shelter = FactoryBot.create(:shelter)
FactoryBot.create_list(:pet, 4, shelter: shelter)

# shelter, reviews, no pets
shelter = FactoryBot.create(:shelter)
FactoryBot.create_list(:review, 4, shelter: shelter)

# shelter, reviews, with adoptable pets
shelter = FactoryBot.create(:shelter)
FactoryBot.create_list(:review, 4, shelter: shelter)
FactoryBot.create_list(:pet, 4, shelter: shelter)

# user, no apps, no reviews
FactoryBot.create(:user)

# user, no apps, yes reviews
user = FactoryBot.create(:user)
FactoryBot.create_list(:review, 4, user: user)


# user, yes apps, yes reviews
user = FactoryBot.create(:user)
FactoryBot.create_list(:review, 4, user: user)
  # app in progress
  FactoryBot.create(:application, user: user)

  # app pending
  app = FactoryBot.create(:application, user: user, status: 'Pending')
  FactoryBot.create_list(:pet_application, 2, application: app)

  # app approved, all pet apps approved
  app = FactoryBot.create(:application, user: user, status: 'Approved')
  pets = FactoryBot.create_list(:pet, 2, adoptable: false)
  FactoryBot.create(:pet_application, application: app, pet: pets.first, status: 'approved')
  FactoryBot.create(:pet_application, application: app, pet: pets.second, status: 'approved')

  # app rejected, some pet apps rejected
  app = FactoryBot.create(:application, user: user, status: 'Rejected')
  pets = FactoryBot.create_list(:pet, 2)
  FactoryBot.create(:pet_application, application: app, pet: pets.first, status: 'approved')
  FactoryBot.create(:pet_application, application: app, pet: pets.second, status: 'rejected')

  # app rejected, all pet apps rejected
  app = FactoryBot.create(:application, user: user, status: 'Rejected')
  pets = FactoryBot.create_list(:pet, 2)
  FactoryBot.create(:pet_application, application: app, pet: pets.first, status: 'rejected')
  FactoryBot.create(:pet_application, application: app, pet: pets.second, status: 'rejected')

  # user, yes apps, no reviews
  user = FactoryBot.create(:user)
    # app in progress
    FactoryBot.create(:application, user: user)

    # app pending
    app = FactoryBot.create(:application, user: user, status: 'Pending')
    FactoryBot.create_list(:pet_application, 2, application: app)

    # app approved, all pet apps approved
    app = FactoryBot.create(:application, user: user, status: 'Approved')
    pets = FactoryBot.create_list(:pet, 2, adoptable: false)
    FactoryBot.create(:pet_application, application: app, pet: pets.first, status: 'approved')
    FactoryBot.create(:pet_application, application: app, pet: pets.second, status: 'approved')

    # app rejected, some pet apps rejected
    app = FactoryBot.create(:application, user: user, status: 'Rejected')
    pets = FactoryBot.create_list(:pet, 2)
    FactoryBot.create(:pet_application, application: app, pet: pets.first, status: 'approved')
    FactoryBot.create(:pet_application, application: app, pet: pets.second, status: 'rejected')

    # app rejected, all pet apps rejected
    app = FactoryBot.create(:application, user: user, status: 'Rejected')
    pets = FactoryBot.create_list(:pet, 2)
    FactoryBot.create(:pet_application, application: app, pet: pets.first, status: 'rejected')
    FactoryBot.create(:pet_application, application: app, pet: pets.second, status: 'rejected')
