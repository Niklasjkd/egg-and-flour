class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @ingredients = ["Sugar", "Milk", "Eggs", "Cheese"]

    @ingredient_types = [
      { image: "landing/Dairy.png", ingredients: @ingredients },
      { image: "landing/Desserts & Snacks.png", ingredients: @ingredients },
      { image: "landing/Fish.png", ingredients: @ingredients },
      { image: "landing/Legumes.png", ingredients: @ingredients },
      { image: "landing/Meats.png", ingredients: @ingredients },
      { image: "landing/Nuts.png", ingredients: @ingredients },
      { image: "landing/Oils.png", ingredients: @ingredients },
      { image: "landing/Sauces.png", ingredients: @ingredients },
      { image: "landing/Seafood.png", ingredients: @ingredients },
      { image: "landing/Seasonings.png", ingredients: @ingredients },
      { image: "landing/Fruits.png", ingredients: @ingredients }
    ]
  end
end
