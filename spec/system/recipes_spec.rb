require 'rails_helper'

RSpec.describe "Recipes", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:chef) { create(:chef) }
  let!(:recipe1) do
    chef.recipes.create(
      name: 'vegetable saute',
      description: 'greate vegetable satee'
    )
  end

  # only happy path is needed here...
  it "get recipes index page and create recipe" do
    recipe2 = chef.recipes.create(
      name: 'chicken saute',
      description: 'greate chicken dish'
    )

    visit recipes_path
    expect(page).to have_text(recipe1.description)
    expect(page).to have_text(recipe2.description)
    expect(page).to have_link(recipe1.name, href: recipe_path(recipe1))
    expect(page).to have_link(recipe2.name, href: recipe_path(recipe2))

    click_on 'New Recipe'
    expect(page).to have_current_path(new_recipe_path)
    fill_in 'recipe_name', with: 'recipe3'
    fill_in 'recipe_description', with: 'recipe3 description'

    expect {
      click_on 'Create Recipe'
    }.to change { Recipe.count }.from(2).to(3)
    recipe3 = Recipe.last
    expect(recipe3.name).to eq('recipe3')
    expect(recipe3.description).to eq('recipe3 description')
    expect(page).to have_current_path(recipe_path(recipe3))
    expect(page).to have_text('recipe3')
    expect(page).to have_text('recipe3 description')
  end

  it "edit and update recipe" do
    visit edit_recipe_path(recipe1)
    # WHY?
    # expect(page).to have_link('Edit this recipe', href: edit_recipe_path(recipe1))

    fill_in 'recipe_name', with: 'new recipe1 name'
    fill_in 'recipe_description', with: 'new recipe1 description'
    click_on 'Update Recipe'
    expect(page).to have_current_path(recipe_path(recipe1))
    expect(page).to have_selector('div.alert')

    recipe1.reload
    expect(recipe1.name).to eq('new recipe1 name')
    expect(recipe1.description).to eq('new recipe1 description')
  end

  it "delete recipe" do
    visit recipe_path(recipe1)
    expect(page).to have_link('Delete this recipe', href: recipe_path(recipe1))

    expect {
      click_on 'Delete this recipe'
    }.to change { Recipe.count }.from(1).to(0)
    expect(page).to have_current_path(recipes_path)
  end
end
