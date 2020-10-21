class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    pet_application = PetApplication.with_ids(params[:pet], params[:id])
    pet_application.update(status: params[:status])
    application = Application.find(params[:id])
    if application.all_pet_apps_approved?
      application.approve_adoption
    elsif application.app_rejected?
      application.reject_adoption
    end
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
