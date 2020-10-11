class PetsController < ApplicationController
  def index
    if params[:adoptable].nil?
      @pets = Pet.all.sort_by(&:status)
    elsif params[:adoptable] == "false"
      @pets = Pet.where(adoptable: false)
    else
      @pets = Pet.where(adoptable: true)
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  private
  def pet_params
    params.permit(:image, :name, :age, :sex, :description, :adoptable, :shelter_id)
  end
end
