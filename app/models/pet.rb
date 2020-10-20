class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications

  def self.display_by(param)
    if param == "true"
      where(adoptable: true)
    elsif param == "false"
      where(adoptable: false)
    else
      order(adoptable: :desc)
    end
  end

  def self.adopted_pets
    joins(:applications).where("applications.status = 'Approved' AND pets.adoptable = 'false' ")
  end

  def self.count_of_pets
    count
  end

  def self.with_names_like(name)
    Pet.where('lower(name) like ?', "%#{name.downcase}%")
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
    applications.exists?(status: 'Approved')
  end
end
