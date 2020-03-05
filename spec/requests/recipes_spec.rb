require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /recipes" do
    let(:chef) { Chef.create(chefname: 'wang', email: 'cwang@example.com') }
    let!(:recipe1) do
      chef.recipes.create(
        name: 'vegetable saute',
        description: 'greate vegetable satee, and vegeable and oil'
      )
    end
    let!(:recipe2) do
      chef.recipes.create(
        name: 'chicken saute',
        description: 'greate chicken dish'
      )
    end

    it "works! (now write some real specs)" do
      get recipes_path
      expect(response).to have_http_status(200)
      expect(response.body).to include(recipe1.name)
      expect(response.body).to include(recipe2.name)
    end
  end
end
