class TripSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :public

  has_many :days
end