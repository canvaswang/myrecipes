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

    it "should get recipes listing" do
      get recipes_path
      expect(response).to have_http_status(200)
      expect(response.body).to include(recipe1.name)
      expect(response.body).to include(recipe2.name)
    end

    it "should get recipes show page" do
      get recipe_path(recipe1)
      expect(response).to have_http_status(200)
      expect(response.body).to include(recipe1.name.capitalize)
      expect(response.body).to include(recipe1.description)
      expect(response.body).to include(chef.chefname)
      # expect(response).to redirect_to('www.google.com')

      # needs gem 'rails-controller-testing'
      # expect(response.body).to render_template('show')
    end
  end
end
