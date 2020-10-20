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

    it 'I cannot create the same user twice' do
      User.create(
        name: 'Jimmy World',
        street_address: '10 Normal Rd',
        city: 'Denver',
        state: 'CO',
        zip: '80249'
      )
      visit '/users/new'

      fill_in :name, with: 'Jimmy World'
      fill_in :street_address, with: '10 Normal Rd'
      fill_in :city, with: 'Denver'
      fill_in :state, with: 'CO'
      fill_in :zip, with: '80249'
      click_on 'Create User'

      expect(current_path).to eq("/users/new")
      expect(page).to have_content('User already exists!')
    end
  end
end
