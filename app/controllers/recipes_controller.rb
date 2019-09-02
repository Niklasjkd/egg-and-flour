class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :create_user_ingredients]

  def index
    # @recipes = [Recipe.find_by(name: "Spanish tortilla")]
    match
    @combined_ingredients
  end

  def create
    recipes = JSON.parse(params[:recipes][:recipes])
    selected_recipes = []
    recipes.each do |recipe|
      if Recipe.exists?(recipe_api_id: recipe["id"])
        recipe = Recipe.find_by(recipe_api_id: recipe["id"])
      else
        recipe = Recipe.new(name: recipe["title"], recipe_api_id: recipe["id"], image: recipe["image"])
        recipe.save
      end
      recipe.requests.create(user: current_user, host: false)
      selected_recipes << recipe
    end
    # raise
    redirect_to requests_path(selected_recipes: selected_recipes)
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
          Ingredient.find(ingredient[:ingredient_id]).name
        end
      }
    end
    @ingredients_by_user = ingredients_by_user
  end

  def match
    ingredients_by_user
    @ingredients = params[:ingredients].split
    create_user_ingredients
    @combined_ingredients = []
    @ingredients_by_user.each do |user_ingredients|
      @combined_ingredients << (@ingredients + user_ingredients[:ingredients])
    end
  end

  def create_user_ingredients
    # if UserIngredient.exists?(user_id: current_user) == false
      @ingredients.each do |ingredient|
        user_ingredient = Ingredient.find_by(name: ingredient).id
         a = UserIngredient.new(user: current_user, ingredient_id: user_ingredient)
        a.save!

    end
  end
end
