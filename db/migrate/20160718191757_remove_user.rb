class RemoveUser < ActiveRecord::Migration[5.0]
  def change
    drop_table :users
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password
      t.string :salt
      t.text :description
      t.datetime :last_sign_in
      t.datetime :last_sign_out
      t.timestamps
    end
  end
end
