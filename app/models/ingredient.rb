class Ingredient < ApplicationRecord
  has_many :user_ingredients
  has_many :recipe_ingredients
  validates :name, presence: true
  validates :unit, presence: true
end
