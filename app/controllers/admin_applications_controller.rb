class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    pet = Pet.find(params[:pet])
    pet.update(adoptable: false)
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
