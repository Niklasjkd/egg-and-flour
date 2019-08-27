class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :requests
  has_many :meetups
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :method, presence: true
  validates :image, presence: true
end
