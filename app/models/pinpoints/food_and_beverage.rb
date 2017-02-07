class FoodAndBeverage < ApplicationRecord
  include Pinpoint

  scope :coffee_shops, -> { where(type: 'CoffeeShop') }
  scope :night_clubs, -> { where(type: 'NightClub') }
  scope :restaurants, -> { where(type: 'Restaurant') }

end