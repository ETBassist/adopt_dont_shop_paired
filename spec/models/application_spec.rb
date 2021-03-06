require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it {should belong_to :user}
    it {should have_many :pet_applications}
    it {should have_many(:pets).through(:pet_applications)}

  end

  describe "instance methods" do
    it ".has_pets" do
      application = create(:application)
      expect(application.has_pets?).to eq(false)

      create(:pet_application, application: application)
      expect(application.has_pets?).to eq(true)
    end

    it ".has_pet?(pet)" do
      application = create(:application)
      pet = create(:pet)
      expect(application.has_pet?(pet)).to eq(false)

      create(:pet_application, application: application, pet: pet)
      expect(application.has_pet?(pet)).to eq(true)
    end

    it ".add_pet(pet)" do
      application = create(:application)

      pet = create(:pet)
      application.add_pet(pet.id)

      expect(application.pets.last).to eq(pet)
    end

    it '.all_pet_apps_approved?' do
      application = create(:application)
      pet1 = create(:pet)
      pet2 = create(:pet)
      pet3 = create(:pet)
      create(:pet_application, application: application, pet: pet1, status: "approved")
      create(:pet_application, application: application, pet: pet2, status: "approved")
      create(:pet_application, application: application, pet: pet3, status: "approved")
      application2 = create(:application)
      create(:pet_application, application: application2, pet: pet1, status: "pending")

      expect(application.all_pet_apps_approved?).to eq(true)
      expect(application2.all_pet_apps_approved?).to eq(false)
    end

    it ".approve_adoption" do
      application = create(:application)
      pet1 = create(:pet)
      pet2 = create(:pet)
      pet3 = create(:pet)
      create(:pet_application, application: application, pet: pet1, status: "approved")
      create(:pet_application, application: application, pet: pet2, status: "approved")
      create(:pet_application, application: application, pet: pet3, status: "approved")
      application.approve_adoption
      expect(application.status).to eq("Approved")
      application.pets.each do |pet|
        expect(pet.adoptable).to eq(false)
      end
    end

    it ".reject_adoption" do
      application = create(:application)
      pet1 = create(:pet)
      pet2 = create(:pet)
      pet3 = create(:pet)
      create(:pet_application, application: application, pet: pet1, status: "approved")
      create(:pet_application, application: application, pet: pet2, status: "approved")
      create(:pet_application, application: application, pet: pet3, status: "rejected")
      application.reject_adoption
      expect(application.status).to eq("Rejected")
      application.pets.each do |pet|
        expect(pet.adoptable).to eq(true)
      end
    end

    it ".any_pet_app_rejected?" do
      application = create(:application)
      pet1 = create(:pet)
      pet2 = create(:pet)
      pet3 = create(:pet)
      create(:pet_application, application: application, pet: pet1, status: "approved")
      create(:pet_application, application: application, pet: pet2, status: "approved")
      create(:pet_application, application: application, pet: pet3, status: "rejected")
      expect(application.app_rejected?).to eq(true)
    end

    it '.check_status' do
      application = create(:application)
      pet1 = create(:pet)
      pet2 = create(:pet)
      pet3 = create(:pet)
      pet4 = create(:pet)
      create(:pet_application, application: application, pet: pet1, status: "approved")
      create(:pet_application, application: application, pet: pet2, status: "approved")
      create(:pet_application, application: application, pet: pet3, status: "approved")
      application2 = create(:application)
      create(:pet_application, application: application2, pet: pet4, status: "rejected")
      
      application.check_status
      expect(application.status).to eq("Approved")
      application.pets.each do |pet|
        expect(pet.adoptable).to eq(false)
      end
      application2.check_status
      expect(application2.status).to eq("Rejected")
      expect(application2.pets.first.adoptable).to eq(true)
    end
  end
end
