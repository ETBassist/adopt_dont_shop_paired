class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def pet_count
    pets.count
  end

  def average_rating
    reviews.average(:rating)
  end

  def application_count
    # TODO: Refactor with ActiveRecord
    pets.sum do |pet|
      pet.applications.count
    end
  end

  def has_approvals?
    pets.any? do |pet|
      pet.has_approvals?
    end
  end
end
