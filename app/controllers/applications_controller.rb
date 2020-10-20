class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:pet_name]
      @pets = Pet.with_names_like(params[:pet_name])
    end
    check_search_results(params, @pets)
  end

  def new
  end

  def create
    user = User.find_by('lower(name) = ?', params[:user_name].downcase)
    check_user_validity(user, app_params)
  end

  def update
    application = Application.find(params[:id])
    check_update_validity(application, params)
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

  def check_update_validity(application, given_params)
    if given_params[:pet]
      application.add_pet(given_params[:pet])
    elsif given_params[:description].empty?
      flash.notice = "Required field: Description"
    elsif given_params[:status]
      application.update(app_params)
    end
  end

  def check_search_results(given_params, pets)
    if given_params[:pet_name] && !pets.nil?
      flash.notice = "Could not find a pet by that name"
    else
      @pets = []
    end
  end
end
