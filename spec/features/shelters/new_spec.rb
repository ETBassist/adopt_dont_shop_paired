require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters' do
    it 'I can create a new shelter' do
      visit '/shelters'

      click_link 'New Shelter'

      expect(current_path).to eq('/shelters/new')

      fill_in 'Name', with: 'Pet Rescue'
      fill_in 'Address', with: '10 Normal Rd'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'CO'
      fill_in 'Zip', with: '80249'
      click_on 'Create Shelter'

      expect(current_path).to eq("/shelters")
      expect(page).to have_content('Pet Rescue')
    end
  end
end
