class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    pet_application = PetApplication.find_by(pet_id: params[:pet], application_id: params[:id])
    pet_application.update(status: params[:status])
    application = Application.find(params[:id])
    if application.pet_applications.all? { |pet_app| pet_app.status == "approved" }
      application.status = "Approved"
      application.save
    end
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
