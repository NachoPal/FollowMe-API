class FoodAndBeverage < ApplicationRecord
  include Pinpoint

  belongs_to :day

  scope :coffee_shops, -> { where(type: 'CoffeeShop') }
  scope :night_clubs, -> { where(type: 'NightClub') }
  scope :restaurants, -> { where(type: 'Restaurant') }

end