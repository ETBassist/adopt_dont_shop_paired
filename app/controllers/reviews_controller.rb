class ReviewsController < ApplicationController
  before_action :find_review, only: [:edit, :update, :destroy]
  before_action :find_user, only: [:create, :update]
  before_action :find_shelter, only: [:create]

  def new
  end

  def create
    return redirect_to_existing_review if Review.check_exists(@user, @shelter)
    @review = @shelter.reviews.new(review_params)
    @review.user = @user
    check_default_image
    if @user.nil?
      flash.now.notice = 'Failed to create review: User must exist'
      render :new
    elsif @review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash.now.notice = 'Please fill out all required fields'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.nil?
      flash.now.notice = 'Failed to edit review: User must exist'
      render :edit
    elsif @review.update(review_params)
      redirect_to "/shelters/#{@review.shelter.id}"
    else
      flash.now.notice = 'Please fill out all required fields'
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to "/shelters/#{@review.shelter.id}"
  end

  private

  def find_review
    @review = Review.find(params[:id])
  end

  def find_user
    @user = User.find_by(name: params[:user_name])
  end

  def find_shelter
    @shelter = Shelter.find(params[:shelter])
  end

  def review_params
    params.permit(:title, :content, :rating, :image)
  end

  def redirect_to_existing_review
    review = Review.check_exists(@user, @shelter)
    flash.notice = 'You already have a review, want to update it?'
    redirect_to "/reviews/#{review.id}/edit"
  end

  def check_default_image
    if params[:image] == ''
      @review.default_image
    end
  end
end
