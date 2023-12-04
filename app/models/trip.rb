class Trip < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :location, optional: true
  has_many :flight_statuses
  has_many :hotel_statuses
  has_many :activity_statuses
  has_many :flights, through: :flight_statuses
  has_many :hotels, through: :hotel_statuses
  has_many :activities, through: :activity_statuses

  validates :name, presence: true
end
