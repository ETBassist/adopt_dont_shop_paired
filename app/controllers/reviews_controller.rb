class ReviewsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:user_name])
    shelter = Shelter.find(params[:shelter])
    review = shelter.reviews.new(review_params)
    review.user = user
    if user.nil?
      flash.notice = 'Failed to create review: User must exist'
      render :new
    elsif review.save
      review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash.notice = "Please fill out all required fields"
      render :new
    end
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
