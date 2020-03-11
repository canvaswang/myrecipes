require 'rails_helper'

RSpec.describe "Recipes", type: :system do
  before do
    # can we set it to
    driven_by(:rack_test)
  end

  let(:chef) { create(:chef) }
  let!(:recipe1) do
    chef.recipes.create(
      name: 'vegetable saute',
      description: 'greate vegetable satee'
    )
  end
  let!(:recipe2) do
    chef.recipes.create(
      name: 'chicken saute',
      description: 'greate chicken dish'
    )
  end

  # only happy path is needed here...
  it "get recipes index page and create recipe" do
    visit recipes_path
    expect(page).to have_text(recipe1.description)
    expect(page).to have_text(recipe2.description)
    expect(page).to have_link(recipe1.name, href: recipe_path(recipe1))
    expect(page).to have_link(recipe2.name, href: recipe_path(recipe2))

    click_on 'New Recipe'
    expect(page).to have_current_path(new_recipe_path)
    fill_in 'recipe_name', with: 'recipe3'
    fill_in 'recipe_description', with: 'recipe3 description'

    click_on 'Create Recipe'
    recipe3 = Recipe.last
    expect(recipe3.name).to eq('recipe3')
    expect(recipe3.description).to eq('recipe3 description')
    expect(page).to have_current_path(recipe_path(recipe3))
    expect(page).to have_text('recipe3')
    expect(page).to have_text('recipe3 description')
  end
end
