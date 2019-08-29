class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    category_arr = Ingredient.all.map{ |ingredient| ingredient.category }
    @ingredient_types = []

    category_arr.each do |category|
      ingredients = Ingredient.where(category: category).order('name ASC').map { |ingredient| ingredient.name }.uniq
      @ingredient_types << { title: category, image: "landing/#{category.gsub(/\s&\s/, '-').gsub(/\s/, '-')}.png", ingredients: ingredients }
    end
  end
end
