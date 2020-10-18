class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shelter

  validates_presence_of :title, :content, :rating

  def default_image
    image = "https://cdn.iconscout.com/icon/premium/png-256-thumb/pet-117-805569.png"
    self.update(image: image)
    self.save
  end
end
