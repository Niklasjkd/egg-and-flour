class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @ingredients = ["Sugar", "Milk", "Eggs", "Cheese"]

    @ingredient_types = [
      { title: "Dairy", image: "landing/Dairy.png", ingredients: @ingredients },
      { title: "Desserts & Snacks", image: "landing/Desserts-Snacks.png", ingredients: @ingredients },
      { title: "Fish", image: "landing/Fish.png", ingredients: @ingredients },
      { title: "Legumes", image: "landing/Legumes.png", ingredients: @ingredients },
      { title: "Meats", image: "landing/Meats.png", ingredients: @ingredients },
      { title: "Nuts", image: "landing/Nuts.png", ingredients: @ingredients },
      { title: "Oils", image: "landing/Oils.png", ingredients: @ingredients },
      { title: "Sauces", image: "landing/Sauces.png", ingredients: @ingredients },
      { title: "Seafood", image: "landing/Seafood.png", ingredients: @ingredients },
      { title: "Seasonings", image: "landing/Seasonings.png", ingredients: @ingredients },
      { title: "Fruits", image: "landing/Fruits.png", ingredients: @ingredients }
    ]
  end
end
