class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def self.best_shelters
    select('AVG(reviews.rating) as avg_rating, shelters.*').joins(:reviews).group(:id).order('avg_rating desc').limit(3)
  end

  def pet_count
    pets.count
  end

  def average_rating
    reviews.average(:rating)
  end

  def application_count
    pets.joins(:applications).count
  end

  def has_approvals?
    pets.any? do |pet|
      pet.has_approvals?
    end
  end
end
