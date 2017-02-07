class TripSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :public, :created_at, :updated_at

  has_many :days
end