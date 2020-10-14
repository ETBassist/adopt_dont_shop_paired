class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shelter

  validates_presence_of :title, :content, :rating
end
