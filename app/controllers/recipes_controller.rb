class RecipesController < ApplicationController
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

  def recipes_params
    params.require(:recipes).permit(:id)
  end
end
