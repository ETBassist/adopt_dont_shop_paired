require 'rails_helper'

describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to :shelter }
    it { should have_many :pet_applications }
    it { should have_many(:applications).through(:pet_applications) }
  end

  describe 'instance methods' do
    it '.status' do
      shelter = Shelter.create!()
      pet_1 = shelter.pets.create!()
      pet_2 = shelter.pets.create!(adoptable: false)

      expect(pet_1.status).to eq('Adoptable')
      expect(pet_2.status).to eq('Pending Adoption')
    end

    it ".pet_application" do
      pet = create(:pet)
      application = create(:application)
      pet_application1 = create(:pet_application, application: application, pet: pet)
      pet_application2 = create(:pet_application, pet: pet)
      expect(pet.pet_application(application.id)).to eq(pet_application1)
      expect(pet.pet_application(application.id)).to_not eq(pet_application2)
    end

    it '.has_approvals?' do
      pet = create(:pet)

      expect(pet.has_approvals?).to eq(false)
      
      user = create(:user)
      pet.applications.create!(user_id: user.id, status: "Approved")

      expect(pet.has_approvals?).to eq(true)
    end
  end
end
