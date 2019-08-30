class UserIngredient < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient
  # validates :quantity, presence: true
  # validates :quantity, numericality: { greater_than: 0 }
end
