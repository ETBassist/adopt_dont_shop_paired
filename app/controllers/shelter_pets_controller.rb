class ShelterPetsController < ApplicationController
  def index
    @pets = Shelter.find(params[:shelter_id]).pets
  end

  def new
  end

  def create
  end

end
