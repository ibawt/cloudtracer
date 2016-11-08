require "rails_helper"

RSpec.describe HeebiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/heebies").to route_to("heebies#index")
    end

    it "routes to #new" do
      expect(:get => "/heebies/new").to route_to("heebies#new")
    end

    it "routes to #show" do
      expect(:get => "/heebies/1").to route_to("heebies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/heebies/1/edit").to route_to("heebies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/heebies").to route_to("heebies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/heebies/1").to route_to("heebies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/heebies/1").to route_to("heebies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/heebies/1").to route_to("heebies#destroy", :id => "1")
    end

  end
end
