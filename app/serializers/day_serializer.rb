class TripSerializer < ActiveModel::Serializer
  attributes :id, :index, :created_at, :updated_at

  belongs_to :trip
end