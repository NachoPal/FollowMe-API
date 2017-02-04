class AddPublicToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :public, :boolean, default: true
  end
end
