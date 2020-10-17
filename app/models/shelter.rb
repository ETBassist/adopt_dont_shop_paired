class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def self.sorted_by(param)
    if param == "adoptable"
      # TODO: Refactor with ActiveRecord
      # Shelter.joins(:pets).group(:id).order(pets.count(:adoptable))
      Shelter.all.sort_by do |shelter|
        shelter.pets.count(:adoptable)
      end.reverse
    elsif param == "alphabetical"
      Shelter.order(:name)
    else
      Shelter.all
    end
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
