require 'rails_helper'

RSpec.describe "Heebies", type: :request do
  describe "GET /heebies" do
    it "works! (now write some real specs)" do
      get heebies_path
      expect(response).to have_http_status(200)
    end
  end
end
