class Trip < ApplicationRecord
  has_many :trip_users
  has_many :users, :through => :trip_users
  has_many :days

  validates :name, presence: true, length: { in: 3..20 }
  validates :description, length: { in: 0..100 }
  validates :public, inclusion: { in: [true, false] }
end
