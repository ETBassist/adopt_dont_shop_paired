require 'rails_helper'

describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to :shelter }
  end

  describe 'instance methods' do
    it '.status' do
      shelter = Shelter.create!()
      pet_1 = shelter.pets.create!()
      pet_2 = shelter.pets.create!(adoptable: false)

      expect(pet_1.status).to eq('Adoptable')
      expect(pet_2.status).to eq('Pending Adoption')
    end
  end
end
