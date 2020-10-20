class ReviewsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:user_name])
    shelter = Shelter.find(params[:shelter])
    if Review.check_exists(user, shelter)
      review = Review.check_exists(user, shelter)
      flash.notice = 'You already have a review, want to update it?'
      redirect_to "/reviews/#{review.id}/edit"
    else
      review = shelter.reviews.new(review_params)
      review.user = user
      if params[:image] == ""
        review.default_image
      end
      if user.nil?
        flash.notice = 'Failed to create review: User must exist'
        render :new
      elsif review.save
        redirect_to "/shelters/#{shelter.id}"
      else
        flash.notice = "Please fill out all required fields"
        render :new
      end
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    user = User.find_by(name: params[:user_name])
    if user.nil?
      flash.notice = 'Failed to edit review: User must exist'
      render :edit
    elsif @review.update(review_params)
      @review.update(review_params)
      redirect_to "/shelters/#{@review.shelter.id}"
    else
      flash.notice = "Please fill out all required fields"
      render :edit
    end
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
