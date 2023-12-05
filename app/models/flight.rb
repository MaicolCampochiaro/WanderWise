class Flight < ApplicationRecord
  has_many :flight_statuses, dependent: :destroy
  has_many :trips, through: :flight_statuses

  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
