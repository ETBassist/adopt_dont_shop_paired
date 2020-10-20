class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @best_review = @user.best_review
    @worst_review = @user.worst_review
  end

  def new
  end

  def create
    if User.find_by(name: params[:name])
      flash.notice = 'User already exists!'
      redirect_to "/users/new"
    else
      user = User.create(user_params)
      redirect_to "/users/#{user.id}"
    end
  end

  private

  def user_params
    params.permit(:name, :street_address, :city, :state, :zip)
  end
end
