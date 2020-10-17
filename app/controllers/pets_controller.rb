class PetsController < ApplicationController
  def index
    @pets = Pet.display_by(params[:adoptable])
  end

  def show
    @pet = Pet.find(params[:id])
    @view = params[:show_apps]
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

  def change_status
    pet = Pet.find(params[:id])
    pet.update({adoptable: !pet.adoptable})
    redirect_to "/pets/#{pet.id}"
  end

  private
  def pet_params
    params.permit(:image, :name, :age, :sex, :description, :adoptable, :shelter_id)
  end
end
