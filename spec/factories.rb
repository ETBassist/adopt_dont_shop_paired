FactoryBot.define do
  factory :shelter do
    name { Faker::University.name + " Shelter" }
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
    adoptable { [true, false].sample }
    shelter
  end

  factory :user do
    name { Faker::Superhero.name }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
  end
end
