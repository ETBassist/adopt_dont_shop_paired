class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    pet_application = PetApplication.find_by(pet_id: params[:pet], application_id: params[:id])
    pet_application.update(status: params[:status])
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
