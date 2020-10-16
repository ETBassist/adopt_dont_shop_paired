require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :reviews }
    it { should have_many :applications }
  end

  describe "instance methods" do
    it "best_review" do
      user = create(:user)

      no_hash = {
        title: "No title",
        rating: "No rating",
        content: "No content"
      }

      expect(user.best_review).to eq(no_hash)

      review1 = create(:review, user: user, rating: 5)
      review2 = create(:review, user: user, rating: 2)

      review1_hash = {
        title: review1.title,
        rating: review1.rating,
        content: review1.content,
        image: review1.image
      }

      review2_hash = {
        title: review2.title,
        rating: review2.rating,
        content: review2.content,
        image: review2.image
      }

      expect(user.best_review).to eq(review1_hash)
    end

    it "worst_review" do
      user = create(:user)

      no_hash = {
        title: "No title",
        rating: "No rating",
        content: "No content"
      }

      expect(user.worst_review).to eq(no_hash)

      review1 = create(:review, user: user, rating: 5)
      review2 = create(:review, user: user, rating: 2)

      review1_hash = {
        title: review1.title,
        rating: review1.rating,
        content: review1.content,
        image: review1.image
      }

      review2_hash = {
        title: review2.title,
        rating: review2.rating,
        content: review2.content,
        image: review2.image
      }

      expect(user.worst_review).to eq(review2_hash)
    end

    it "full_address" do
      user = create(:user)
      address = "#{user.street_address} #{user.city}, #{user.state} #{user.zip}"
      expect(user.full_address).to eq(address)
    end
  end
end
