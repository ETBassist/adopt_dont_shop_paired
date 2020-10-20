class Application < ApplicationRecord
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def has_pets?
    pets.exists?
  end

  def has_pet?(pet)
    pets.exists?(pet.id)
  end
end
