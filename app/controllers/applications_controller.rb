class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    user = User.find_by(name: params[:user_name])
    if user
      app = user.applications.create(app_params)
      redirect_to "/applications/#{app.id}"
    else
      flash.notice = "Invalid User Name"
      redirect_to "/applications/new"
    end
  end

  private
  def app_params
    params.permit(:status)
  end
end
