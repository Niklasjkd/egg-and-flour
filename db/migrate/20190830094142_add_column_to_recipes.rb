class AddColumnToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :recipe_api_id, :string
  end
end
