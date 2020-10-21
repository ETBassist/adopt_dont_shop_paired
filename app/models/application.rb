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

  def add_pet(pet_id)
    pets << Pet.find(pet_id)
  end

  def check_status
    if all_pet_apps_approved?
      approve_adoption
    elsif app_rejected?
      reject_adoption
    end
  end

  def all_pet_apps_approved?
    pet_applications.all? { |pet_app| pet_app.status == "approved" }
  end

  def app_rejected?
    pet_applications.all?(&:status)
  end

  def approve_adoption
    self.status = "Approved"
    pets.each do |pet|
      pet.adoptable = false
      pet.save
    end
    save
  end

  def reject_adoption
    self.status = "Rejected"
    save
  end
end

