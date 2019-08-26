class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :requests
  has_many :meetups
end
