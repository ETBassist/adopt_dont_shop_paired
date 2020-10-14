require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit an application show page' do
    before (:each) do
      user = create(:user)
      shelter = create(:shelter)
      

      app = create(:app, user: user, shelter: shelter, pet_application: pet_application)
    end
    it 'I see the application information' do
      visit "/applications/#{app.id}"

      expect(page).to have_content(app.user.name)
      expect(page).to have_content(app.user.full_address)
      expect(page).to have_content(app.description)
      expect(page).to have_link(app.pets.first)
      expect(page).to have_content(app.status)

    end
  end
end
