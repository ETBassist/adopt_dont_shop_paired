class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def self.display_by(param)
    if param == "true"
      Pet.where(adoptable: true)
    elsif param == "false"
      Pet.where(adoptable: false)
    else
      Pet.order(adoptable: :desc)
    end
  end

  def status
    if adoptable?
      "Adoptable"
    else
      "Pending Adoption"
    end
  end

  def approve_pet
    adoptable == false
  end
end
