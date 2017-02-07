class Entertainment < ApplicationRecord
  include Pinpoint

  belongs_to :day

  scope :art_galleries, -> { where(type: 'ArtGallery') }
  scope :museums, -> { where(type: 'Museum') }
  scope :theaters, -> { where(type: 'Theater') }
  scope :tickets, -> { where(type: 'Ticket') }

end