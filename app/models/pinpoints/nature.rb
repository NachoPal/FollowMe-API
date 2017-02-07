class Nature < ApplicationRecord
  include Pinpoint

  belongs_to :day

  scope :beaches, -> { where(type: 'Beach') }
  scope :countrysides, -> { where(type: 'Countryside') }
end