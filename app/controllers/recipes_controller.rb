class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    match
    recipe_ids = []
    @scores.each do |score|
      recipe_ids << (score[:recipe_id] unless score[:score] == 0)
    end
    @recipes = Recipe.find(recipe_ids)
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

  def ingredients_by_user
    users = User.all
    ingredients_by_user = []
    users.each do |user|
      ingredients_by_user << {
        user_id: user.id,
        ingredients: UserIngredient.where(user_id: user.id).map do |ingredient|
          ingredient.id
        end
      }
    end
    @ingredients_by_user = ingredients_by_user
  end

  def recipes_by_ingredients
    recipes = Recipe.all
    recipes_by_ingredients = []
    recipes.each do |recipe|
      recipes_by_ingredients << {
        recipe_id: recipe.id,
        ingredients: RecipeIngredient.where(recipe_id: recipe.id).map do |ingredient|
          ingredient.id
        end
      }
    end
    @recipes_by_ingredients = recipes_by_ingredients
  end

  def match
    recipes_by_ingredients
    ingredients_by_user
    #change to ingredients = params...
    ingredients = [Ingredient.where(name: "avocado").first.id, Ingredient.where(name: "Eggs").first.id]
    @scores = []
    @ingredients_by_user.each do |user_ingredients|
      @recipes_by_ingredients.each do |recipe|
        counter = 0
        missing = []
        recipe[:ingredients].each do |ingredient|
          if (ingredients + user_ingredients[:ingredients]).include?(ingredient)
            counter += 1
          else
            missing << ingredient
          end
        end
        @scores << {
          recipe_id: recipe[:recipe_id],
          score: counter,
          missing: missing
        }
      end
      break
    end
  end
end
