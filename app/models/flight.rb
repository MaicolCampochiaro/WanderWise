class Flight < ApplicationRecord
  has_many :flight_statuses, dependent: :destroy
  has_many :trips, through: :flight_statuses

  validates :start_location, :end_location, :start_date, :end_date, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
