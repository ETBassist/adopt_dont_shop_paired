FactoryBot.define do
  factory :shelter do
    name { Faker::University.name + " Shelter" }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
  end

  factory :pet do
    name { Faker::University.name + " Shelter" }
    image { "https://placedog.net/280/id=" + rand(1..160).to_s}
    age { rand(1..16).to_s }
    sex { "Male" }
    association :shelter
  end
end
