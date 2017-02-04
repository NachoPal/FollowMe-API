class CreateDays < ActiveRecord::Migration[5.0]
  def change
    create_table :days do |t|
      t.integer :index
      t.belongs_to :trip, index: true
      t.timestamps
    end
  end
end
