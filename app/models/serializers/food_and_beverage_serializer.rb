class FoodAndBeverageSerializer < ActiveModel::Serializer
  attributes :name, :description

  belongs_to :day
end