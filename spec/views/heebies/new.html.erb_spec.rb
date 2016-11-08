require 'rails_helper'

RSpec.describe "heebies/new", type: :view do
  before(:each) do
    assign(:heebie, Heebie.new(
      :name => "MyString",
      :age => ""
    ))
  end

  it "renders new heebie form" do
    render

    assert_select "form[action=?][method=?]", heebies_path, "post" do

      assert_select "input#heebie_name[name=?]", "heebie[name]"

      assert_select "input#heebie_age[name=?]", "heebie[age]"
    end
  end
end
