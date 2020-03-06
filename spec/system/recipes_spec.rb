require 'rails_helper'

RSpec.describe "Recipes", type: :system do
  before do
    driven_by(:rack_test)
  end

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

  it "should get recipes index page" do
    visit "/recipes"
    expect(page).to have_text(recipe1.description)
    expect(page).to have_text(recipe2.description)
    expect(page).to have_link(recipe1.name, href: recipe_path(recipe1))
    expect(page).to have_link(recipe2.name, href: recipe_path(recipe2))
  end
end
