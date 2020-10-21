require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it { should belong_to :pet }
    it { should belong_to :application }
  end

  describe "model methods" do
    application = create(:application)
    pet = create(:pet)
    pet_app = create(:pet_application, pet: pet, application: application)
    expect(PetApplication.with_ids(pet.id, application.id)).to eq(pet_app)
  end
end
