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

      pet_application = create(:pet_application, application: application)
      expect(application.has_pets?).to eq(true)
    end

    it ".has_pet?(pet)" do
      application = create(:application)
      pet = create(:pet)
      expect(application.has_pet?(pet)).to eq(false)

      pet_application = create(:pet_application, application: application, pet: pet)
      expect(application.has_pet?(pet)).to eq(true)
    end
  end

end
