require 'rails_helper'

RSpec.describe "heebies/index", type: :view do
  before(:each) do
    assign(:heebies, [
      Heebie.create!(
        :name => "Name",
        :age => ""
      ),
      Heebie.create!(
        :name => "Name",
        :age => ""
      )
    ])
  end

  it "renders a list of heebies" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
