class AddForUserToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :for_user_id, :bigint
  end
end
