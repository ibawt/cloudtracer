require 'rails_helper'

RSpec.describe "heebies/edit", type: :view do
  before(:each) do
    @heebie = assign(:heebie, Heebie.create!(
      :name => "MyString",
      :age => ""
    ))
  end

  it "renders the edit heebie form" do
    render

    assert_select "form[action=?][method=?]", heebie_path(@heebie), "post" do

      assert_select "input#heebie_name[name=?]", "heebie[name]"

      assert_select "input#heebie_age[name=?]", "heebie[age]"
    end
  end
end
