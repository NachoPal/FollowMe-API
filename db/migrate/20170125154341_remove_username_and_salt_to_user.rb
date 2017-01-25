class RemoveUsernameAndSaltToUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :salt, :string
    remove_column :users, :username, :string
  end
end
