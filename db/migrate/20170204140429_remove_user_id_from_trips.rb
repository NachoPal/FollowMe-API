class RemoveUserIdFromTrips < ActiveRecord::Migration[5.0]
  def change
    remove_column :trips, :user_id, :integer
  end
end
