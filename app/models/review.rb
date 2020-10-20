class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shelter

  validates_presence_of :title, :content, :rating

  def self.check_exists(user, shelter)
    Review.find_by(user: user, shelter: shelter)
  end

  def default_image
    image = "https://cdn.iconscout.com/icon/premium/png-256-thumb/pet-117-805569.png"
    self.update(image: image)
    self.save
  end
end
