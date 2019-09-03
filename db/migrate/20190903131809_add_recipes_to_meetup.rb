class AddRecipesToMeetup < ActiveRecord::Migration[5.2]
  def change
    add_column :meetups, :recipes, :string
  end
end
