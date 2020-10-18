require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
  end

  describe "instance methods" do
    it ".default_image" do
      review = create(:review, image: "")
      image = "https://cdn.iconscout.com/icon/premium/png-256-thumb/pet-117-805569.png"
      correct = review.update(image: image )
      expect(review.default_image).to eq(correct)
    end
  end
end
