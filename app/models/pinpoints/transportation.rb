class Transportation < ApplicationRecord
  include Pinpoint

  scope :airports, -> { where(type: 'Airport') }
  scope :bus_stations, -> { where(type: 'BusStation') }
  scope :train_stations, -> { where(type: 'TrainStation') }
  scope :ports, -> { where(type: 'Port') }
end