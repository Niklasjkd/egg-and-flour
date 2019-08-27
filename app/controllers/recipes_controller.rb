class RecipesController < ApplicationController
  before_action :set_recipe, only: [:index, :show]
  def index
    @recipes = Recipe.all
  end

  def show
    set_recipe
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
