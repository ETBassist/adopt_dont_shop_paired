class Application < ApplicationRecord
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def has_pets?
    pets.any?
  end
end
