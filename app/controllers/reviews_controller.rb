class ReviewsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:user_name])
    shelter = Shelter.find(params[:shelter])
    shelter.reviews.create({
      user: user,
      title: params[:title],
      content: params[:content],
      rating: params[:rating],
      image: params[:image]
      })
    redirect_to "/shelters/#{shelter.id}"
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to "/reviews/#{review.id}"
  end

  def destroy
    Review.destroy(params[:id])
    redirect_to '/reviews'
  end
end
