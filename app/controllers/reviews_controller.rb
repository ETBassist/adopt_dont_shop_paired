class ReviewsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:user_name])
    shelter = Shelter.find(params[:shelter])
    review = shelter.reviews.new({
      user: user,
      title: params[:title],
      content: params[:content],
      rating: params[:rating],
      image: params[:image]
    })
    if review.save
      review.save
    else
      flash.notice = "Please fill out all required fields"
    end
    redirect_to "/shelters/#{shelter.id}"
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to "/shelters/#{review.shelter.id}"
  end

  def destroy
    review = Review.find(params[:id])
    shelter_id = review.shelter.id
    review.destroy
    redirect_to "/shelters/#{shelter_id}"
  end

  private

  def review_params
    params.permit(:title, :content, :rating, :image)
  end
end
