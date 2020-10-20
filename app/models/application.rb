class Application < ApplicationRecord
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def has_pets?
    pets.any?
  end

  def has_pet?(pet)
    pets.include?(pet)
  end

  def add_pet(pet_id)
    pet = Pet.find(pet_id)
    pets << pet
  end
end
