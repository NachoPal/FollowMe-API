class Accommodation < ApplicationRecord
  include Pinpoint

  scope :hotels, -> { where(type: 'Hotel') }
  scope :houses, -> { where(type: 'House') }
end