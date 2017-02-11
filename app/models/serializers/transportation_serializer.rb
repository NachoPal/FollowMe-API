class TransportationSerializer < ActiveModel::Serializer
  attributes :type, :name, :description

  belongs_to :day
end