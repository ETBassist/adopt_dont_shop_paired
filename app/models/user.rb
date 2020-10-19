class User < ApplicationRecord
  has_many :reviews
  has_many :applications, dependent: :destroy

  def best_review
    best = reviews.order(rating: :desc).limit(1).first
    if best
      {
        title: best.title,
        rating: best.rating,
        content: best.content,
        image: best.image
      }
    else
      {
        title: "No title",
        rating: "No rating",
        content: "No content"
      }
    end
  end

  def worst_review
    worst = reviews.order(:rating).limit(1).last
    if worst
      {
        title: worst.title,
        rating: worst.rating,
        content: worst.content,
        image: worst.image
      }
    else
      {
        title: "No title",
        rating: "No rating",
        content: "No content"
      }
    end
  end

  def full_address
    "#{self.street_address} #{self.city}, #{self.state} #{self.zip}"
  end
end
