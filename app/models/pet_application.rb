class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.with_ids(pet_id, app_id)
    PetApplication.find_by(pet_id: pet_id, application_id: app_id)
  end
end
