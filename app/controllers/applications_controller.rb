class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:pet_name]
      @pets = Pet.where('lower(name) like ?', "%#{params[:pet_name].downcase}%")
    end
    if params[:pet_name] && !@pets.nil?
      flash.notice = "Could not find a pet by that name"
    else
      @pets = []
    end
  end

  def new
  end

  def create
    user = User.find_by('lower(name) = ?', params[:user_name].downcase)
    check_user_validity(user, app_params)
  end

  def update
    application = Application.find(params[:id])
    if params[:pet]
      pet = Pet.find(params[:pet])
      application.pets << pet
    elsif params[:description].empty?
      flash.notice = "Required field: Description"
    elsif params[:status]
      application.update(app_params)
    end
    redirect_to "/applications/#{application.id}"
  end

  private
  def app_params
    params.permit(:status, :description)
  end

  def check_user_validity(user, given_params)
    if user
      app = user.applications.create(given_params)
      redirect_to "/applications/#{app.id}"
    else
      flash.notice = "Invalid User Name"
      redirect_to "/applications/new"
    end
  end
end
