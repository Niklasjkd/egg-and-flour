class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.string :category
      t.text :mathod
      t.string :image

      t.timestamps
    end
  end
end
