require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :reviews }
    it { should have_many :applications }
  end

  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "instance methods" do
    it "best_review" do
      user = create(:user)

      expect(user.best_review).to eq(nil)

      user_2 = create(:user)
      review_1 = create(:review, user: user_2, rating: 5)
      review_2 = create(:review, user: user_2, rating: 2)

      expect(user_2.best_review).to eq(review_1)
      expect(user_2.best_review).to_not eq(review_2)
    end

    it "worst_review" do
      user = create(:user)

      expect(user.worst_review).to eq(nil)

      review1 = create(:review, user: user, rating: 5)
      review2 = create(:review, user: user, rating: 2)

      expect(user.worst_review).to eq(review2)
      expect(user.worst_review).to_not eq(review1)
    end

    it "full_address" do
      user = create(:user)
      address = "#{user.street_address} #{user.city}, #{user.state} #{user.zip}"
      expect(user.full_address).to eq(address)
    end
  end
end
