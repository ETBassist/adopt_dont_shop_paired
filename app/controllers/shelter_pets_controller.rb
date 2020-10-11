class ShelterPetsController < ApplicationController
  def index
    @shelter = Shelter.find(params[:shelter_id])

    if params[:adoptable].nil?
      @pets = @shelter.pets.sort_by(&:status)
    elsif params[:adoptable] == "false"
      @pets = @shelter.pets.where(adoptable: false)
    else
      @pets = @shelter.pets.where(adoptable: true)
    end
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    Pet.create(pet_params)
    redirect_to "/shelters/#{pet_params[:shelter_id]}/pets"
  end

  private
  def pet_params
    params.permit(:image, :name, :age, :sex, :description, :adoptable, :shelter_id)
  end
end
