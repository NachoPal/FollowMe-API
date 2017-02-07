class Accommodation < ApplicationRecord
  include Pinpoint

  belongs_to :day

  scope :hotels, -> { where(type: 'Hotel') }
  scope :houses, -> { where(type: 'House') }
end