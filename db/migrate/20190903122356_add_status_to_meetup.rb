class AddStatusToMeetup < ActiveRecord::Migration[5.2]
  def change
    add_column :meetups, :status, :string
  end
end
