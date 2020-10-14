require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit an application show page' do
    before (:each) do
      @user = create(:user)
      @shelter = create(:shelter)
      @pet = create(:pet, shelter: @shelter)

      @app = create(:application, user: @user)
      @pet_application = create(:pet_application, pet: @pet, application: @app)
    end

    it 'I see the application information' do
      visit "/applications/#{@app.id}"

      expect(page).to have_content(@app.user.name)
      expect(page).to have_content(@app.user.full_address)
      expect(page).to have_content(@app.description)
      expect(page).to have_link(@app.pets.first.name)
      expect(page).to have_content(@app.status)

    end
  end
end
