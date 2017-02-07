class TripSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :public

  has_many :days
  #has_many :accommodations, :through => :days
end