class AddPinpointsTables < ActiveRecord::Migration[5.0]
  def change
    create_table :accommodations do |t|
      t.string :type
      t.string :name
      t.string :description
      t.belongs_to :day, index: true
      t.timestamps
    end

    create_table :entertainments do |t|
      t.string :type
      t.string :name
      t.string :description
      t.belongs_to :day, index: true
      t.timestamps
    end

    create_table :food_and_beverages do |t|
      t.string :type
      t.string :name
      t.string :description
      t.belongs_to :day, index: true
      t.timestamps
    end

    create_table :natures do |t|
      t.string :type
      t.string :name
      t.string :description
      t.belongs_to :day, index: true
      t.timestamps
    end

    create_table :transportations do |t|
      t.string :type
      t.string :name
      t.string :description
      t.belongs_to :day, index: true
      t.timestamps
    end

    create_table :point_of_interests do |t|
      t.string :name
      t.string :description
      t.belongs_to :day, index: true
      t.timestamps
    end
  end
end
