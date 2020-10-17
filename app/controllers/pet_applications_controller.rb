class PetApplicationsController < ApplicationController
  def index
    @pet_apps = PetApplication.where(pet_id: params[:pet_id])
  end
end
