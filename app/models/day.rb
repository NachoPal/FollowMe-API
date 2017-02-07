class Day < ApplicationRecord
  belongs_to :trip

  has_many :accommodations
  has_many :entertainments
  has_many :food_and_beverages
  has_many :natures
  has_many :point_of_interests
  has_many :transportations

  #scope :hotels, -> { joins(:accommodations).where(accommodations: {type: 'Hotel'}) }
end
