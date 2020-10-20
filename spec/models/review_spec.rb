require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
  end

  describe "class methods" do
    it '.sorted_by' do
      shelter = Shelter.create
      review1 = create(:review, shelter: shelter, rating: 1, title: 'WTF')
      review2 = create(:review, shelter: shelter, rating: 1, title: 'SRSLY ppl?')
      review3 = create(:review, shelter: shelter, rating: 5, title: 'Wowza')
      review4 = create(:review, shelter: shelter, rating: 2, title: 'Meh. Sure.')
      review5 = create(:review, shelter: shelter, rating: 1, title: 'Run. Fast.')
      review6 = create(:review, shelter: shelter, rating: 5, title: 'Love it.')

      highest = [review6, review3, review4, review5, review2, review1]
      lowest = highest.reverse
      normal = [review1, review2, review3, review4, review5, review6]

      expect(Review.sorted_by("highest")).to eq(highest)
      expect(Review.sorted_by("lowest")).to eq(lowest)
      expect(Review.sorted_by(nil)).to eq(normal)
    end

    it ".check_exists" do
      shelter = Shelter.create
      user = User.create
      review1 = create(:review, user: user, shelter: shelter, rating: 1, title: 'WTF')

      expect(Review.check_exists(user, shelter)).to eq(review1)
    end
  end

  describe "instance methods" do
    it ".default_image" do
      review = create(:review, image: "")
      image = "https://cdn.iconscout.com/icon/premium/png-256-thumb/pet-117-805569.png"
      correct = review.update(image: image)
      expect(review.default_image).to eq(correct)
    end
  end
end
