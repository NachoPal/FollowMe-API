class AccommodationSerializer < ActiveModel::Serializer
  attributes :type, :name, :description

  belongs_to :day
end

