require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /users/new' do
    it 'I see a form to create a new user' do
      visit '/users/new'

      fill_in :name, with: 'Jimmy World'
      fill_in :street_address, with: '10 Normal Rd'
      fill_in :city, with: 'Denver'
      fill_in :state, with: 'CO'
      fill_in :zip, with: '80249'
      click_on 'Create User'

      expect(current_path).to eq("/users/#{User.first.id}")
      expect(page).to have_content('Jimmy World')
    end
  end
end
