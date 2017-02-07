class DaySerializer < ActiveModel::Serializer
  attributes :id, :index

  belongs_to :trip

  has_many :accommodations
  has_many :entertainments
  has_many :food_and_beverages
  has_many :natures
  has_many :point_of_interests
  has_many :transportations
end