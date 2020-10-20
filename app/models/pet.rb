class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
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

  def self.adopted_pets
    Pet.joins(:applications).where("applications.status = 'Approved' AND pets.adoptable = 'false' ")
  end

  def self.count_of_pets
    Pet.count
  end

  def status
    if adoptable?
      "Adoptable"
    else
      "Pending Adoption"
    end
  end

  def pet_application(application_id)
    PetApplication.find_by(pet_id: id, application_id: application_id)
  end

  def has_approvals?
    # TODO: Refactor into ActiveRecord query
    applications.any? do |app|
      app.status == 'Approved'
    end
  end
end
