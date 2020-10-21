class User < ApplicationRecord
  has_many :reviews
  has_many :applications, dependent: :destroy

  def best_review
    reviews.order(rating: :desc).limit(1).first
  end

  def worst_review
    reviews.order(:rating).limit(1).last
  end

  def average_review_rating
    reviews.average(:rating)
  end
end
