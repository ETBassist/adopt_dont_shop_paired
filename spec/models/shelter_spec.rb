require 'rails_helper'

describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many :pets }
    it { should have_many :reviews }
  end

  describe 'class methods' do
    it '.sorted_by' do

    end
  end

  describe 'instance methods' do
    it '.pet_count' do
      shelter = create(:shelter)
      create_list(:pet, 5, shelter: shelter)

      expect(shelter.pet_count).to eq(5)
    end

    it '.average_rating' do
      shelter = create(:shelter)
      create(:review, rating: 5, shelter: shelter)
      create(:review, rating: 1, shelter: shelter)
      create(:review, rating: 1, shelter: shelter)

      expect(shelter.average_rating.round(2)).to eq(2.33)
    end

    it '.application_count' do
      shelter = create(:shelter)
      pet1 = create(:pet, shelter: shelter)
      pet2 = create(:pet, shelter: shelter)

      create(:pet_application, pet: pet1)
      create(:pet_application, pet: pet1)
      create(:pet_application, pet: pet2)
      create(:pet_application, pet: pet2)
      create(:pet_application, pet: pet2)

      expect(shelter.application_count).to eq(5)
    end
  end
end
