class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    category_arr = Ingredient.all.map{ |ingredient| ingredient.category }.uniq

    @ingredient_types = category_arr.map do |category|
      ingredients = Ingredient.where(category: category).order('name ASC').map { |ingredient| ingredient.name }
      { title: category.capitalize, image: "landing/#{category.gsub(/\s&\s/, '-').gsub(/\s/, '-')}.png", ingredients: ingredients }
    end
  end
end
