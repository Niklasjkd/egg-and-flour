class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :recipe, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :host

      t.timestamps
    end
  end
end
