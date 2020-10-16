require 'rails_helper'

describe "As an Visitor" do
  describe "when I visit an admin application show page" do
    before :each do
      @app = create(:application, status: "Pending")
      @pet_app1 = create(:pet_application, application: @app)
      @pet_app2 = create(:pet_application, application: @app)
    end

    it "I can approve pets on an application" do
      visit "/admin/applications/#{@app.id}"

      within("#pet-#{@app.pets.first.id}") do
        click_button('Approve')
        expect(current_path).to eq("/admin/applications/#{@app.id}")
        expect(page).to have_content("Approved")
      end

      within("#pet-#{@app.pets.last.id}") do
        expect(page).to have_button("Approve")
        expect(page).to_not have_content("Approved")
      end
    end
    
    it "I can approve pets on an application" do
      visit "/admin/applications/#{@app.id}"

      within("#pet-#{@app.pets.first.id}") do
        click_button('Reject')
        expect(current_path).to eq("/admin/applications/#{@app.id}")
        expect(page).to have_content("Rejected")
      end

      within("#pet-#{@app.pets.last.id}") do
        expect(page).to have_button("Approve")
        expect(page).to have_button("Reject")
        expect(page).to_not have_content("Rejected")
      end
    end
  end
end
