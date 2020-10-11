class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def pet_params
    params.permit(:image, :name, :age, :sex, :description, :adoptable, :shelter_id)
  end
end
