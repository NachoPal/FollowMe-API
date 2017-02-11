class PointOfInterestSerializer < ActiveModel::Serializer
  attributes :type, :name, :description

  belongs_to :day
end