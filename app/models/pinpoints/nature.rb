class Nature < ApplicationRecord
  include Pinpoint

  scope :beaches, -> { where(type: 'Beach') }
  scope :countrysides, -> { where(type: 'Countryside') }
end