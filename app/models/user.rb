class User < ApplicationRecord
  has_many :reviews

  def best_review
    best = reviews.order(:rating).last
    {
      title: best.title,
      rating: best.rating,
      content: best.content, 
      image: best.image
    }
  end

  def worst_review
    worst = reviews.order(:rating).first
    {
      title: worst.title,
      rating: worst.rating,
      content: worst.content,
      image: worst.image
    }
  end
end
