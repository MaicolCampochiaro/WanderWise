class Trip < ApplicationRecord
  belongs_to :users
  belongs_to :locations
  has_many :flight_statuses
  has_many :hotel_statuses
  has_many :activity_statuses
end
