class SheltersController < ApplicationController
  def index
    if params[:sort].nil?
      @shelters = Shelter.all
    elsif params[:sort] == "adoptable"
      @shelters = Shelter.all.sort_by do |shelter|
        shelter.pets.count(&:adoptable)
      end.reverse
    else #alphabetical
      @shelters = Shelter.all.sort_by(&:name)
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    Shelter.create(shelter_params)
    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
