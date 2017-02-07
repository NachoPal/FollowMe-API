class PointOfInterest < ApplicationRecord
  include Pinpoint

  belongs_to :day
end