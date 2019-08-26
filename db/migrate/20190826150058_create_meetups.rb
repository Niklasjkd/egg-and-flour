class CreateMeetups < ActiveRecord::Migration[5.2]
  def change
    create_table :meetups do |t|
      t.references :recipe, foreign_key: true
      t.references :host, foreign_key: { to_table: :users }
      t.references :guest, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
