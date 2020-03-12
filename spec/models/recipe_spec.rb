require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context 'validations' do
    let(:chef) { create(:chef) }
    let(:recipe) { build_stubbed(:recipe, chef: chef) }

    specify 'recipe should be valid' do
      expect(recipe).to be_valid
    end

    specify 'recipe name should be present' do
      recipe.name = nil
      expect(recipe).not_to be_valid
    end

    specify 'description should be present' do
      recipe.description = nil
      expect(recipe).not_to be_valid
    end

    specify 'description should be at least 5 charaters' do
      recipe.description = '1234'
      expect(recipe).not_to be_valid
      recipe.description = '12345'
      expect(recipe).to be_valid
    end

    specify 'recipe without chef should be invalid' do
      recipe.chef = nil
      expect(recipe).not_to be_valid
    end
  end
end
