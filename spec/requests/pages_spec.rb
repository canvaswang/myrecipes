require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /pages" do
    it "should get home" do
      get pages_home_path
      expect(response).to have_http_status(200)
    end

    it "should get root" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
