class User < ApplicationRecord
  has_many :reviews

  def best_review
    best = reviews.order(:rating).last
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
    worst = reviews.order(:rating).first
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
end
