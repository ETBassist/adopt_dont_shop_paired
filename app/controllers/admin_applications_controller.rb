class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    pet_application = PetApplication.find_by(pet_id: params[:pet], application_id: params[:id])
    pet_application.update(status: params[:status])
    application = Application.find(params[:id])
    if application.all_pet_apps_approved?
      application.status = "Approved"
      application.pets.each do |pet|
        pet.adoptable = false
        pet.save
      end
      application.save
    elsif application.pet_applications.all?(&:status)
      application.status = "Rejected"
      application.save
    end
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
