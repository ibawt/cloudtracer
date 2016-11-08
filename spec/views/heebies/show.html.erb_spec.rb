require 'rails_helper'

RSpec.describe "heebies/show", type: :view do
  before(:each) do
    @heebie = assign(:heebie, Heebie.create!(
      :name => "Name",
      :age => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
