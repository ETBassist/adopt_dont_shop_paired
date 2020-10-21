class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    pet_application = PetApplication.with_ids(params[:pet], params[:id])
    pet_application.update(status: params[:status])
    Application.find(params[:id]).check_status
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
