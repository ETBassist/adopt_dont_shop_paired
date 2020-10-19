class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def self.best_shelters
    sorted_shelters = self.all.sort_by do |shelter|
      if shelter.average_rating
        shelter.average_rating
      else
        0
      end
    end
    sorted_shelters.reverse.first(3)
  end

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
