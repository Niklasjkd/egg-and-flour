class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  # def set_recipe

  # end

  def recipes_params
    params.require(:recipes).permit(:id)
  end
end
