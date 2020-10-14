class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    user = User.find_by(name: params[:user_name])
    app = user.applications.create(app_params)
    redirect_to "/applications/#{app.id}"
  end

  private
  def app_params
    params.permit(:status)
  end
end
