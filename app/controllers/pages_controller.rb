class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    category_arr = Ingredient.all.map{ |ingredient| ingredient.category }.uniq
    @ingredient_types = []

    category_arr.each do |category|
      ingredients = Ingredient.where(category: category).order('name ASC').map { |ingredient| ingredient.name }.uniq
      @ingredient_types << { title: category, image: "landing/#{category}.png", ingredients: ingredients }
    end

    # @ingredients = ["Sugar", "Milk", "Eggs", "Cheese"]

    # @ingredient_types = [
    #   { title: "Dairy", image: "landing/dairy.png", ingredients: @ingredients },
    #   { title: "Desserts & Snacks", image: "landing/desserts-snacks.png", ingredients: @ingredients },
    #   { title: "Fish", image: "landing/fish.png", ingredients: @ingredients },
    #   { title: "Legumes", image: "landing/legumes.png", ingredients: @ingredients },
    #   { title: "Meats", image: "landing/meats.png", ingredients: @ingredients },
    #   { title: "Nuts", image: "landing/nuts.png", ingredients: @ingredients },
    #   { title: "Oils", image: "landing/oils.png", ingredients: @ingredients },
    #   { title: "Sauces", image: "landing/sauces.png", ingredients: @ingredients },
    #   { title: "Seafood", image: "landing/seafood.png", ingredients: @ingredients },
    #   { title: "Seasonings", image: "landing/seasonings.png", ingredients: @ingredients },
    #   { title: "Fruits", image: "landing/fruits.png", ingredients: @ingredients }
    # ]
  end
end
