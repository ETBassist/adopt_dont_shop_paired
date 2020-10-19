FactoryBot.define do
  factory :pet_application do
    pet
    application
    status {}
  end

  factory :application do
    description { Faker::Company.bs }
    status { 'In Progress' }
    user
  end

  factory :shelter do
    name { Faker::Games::Zelda.location + " Shelter" }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
  end

  factory :pet do
    name { Faker::Games::Pokemon.name }
    image { "https://placedog.net/280/id=" + rand(1..160).to_s}
    age { rand(1..16).to_s }
    sex { ["Male", "Female"].sample }
    adoptable { true }
    shelter
  end

  factory :user do
    name { Faker::Superhero.name }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
  end

  factory :review do
    title { "I love my #{Faker::Creature::Dog.meme_phrase}" }
    rating { rand(1..5).to_s}
    content { Faker::Movies::HarryPotter.quote }
    image { "https://placedog.net/100/id=" + rand(1..160).to_s }
    shelter
    user
  end
end
