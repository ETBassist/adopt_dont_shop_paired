require 'rails_helper'

RSpec.describe "pets/index", type: :view do
  before(:each) do
    assign(:pets, [
      Pet.create!(
        image: "Image",
        name: "Name",
        age: "Age",
        sex: "Sex",
        adoptable: false,
        shelter: nil
      ),
      Pet.create!(
        image: "Image",
        name: "Name",
        age: "Age",
        sex: "Sex",
        adoptable: false,
        shelter: nil
      )
    ])
  end

  it "renders a list of pets" do
    render
    assert_select "tr>td", text: "Image".to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Age".to_s, count: 2
    assert_select "tr>td", text: "Sex".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
