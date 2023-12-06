class Trip < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :location, optional: true
  has_many :flight_statuses
  has_many :room_statuses
  has_many :activity_statuses
  has_many :flights, through: :flight_statuses
  has_many :hotels, through: :room_statuses
  has_many :activities, through: :activity_statuses

  validates :name, presence: true
  def date_range
    start_date = flights.last.start_date
    end_date = flights.last.end_date

    (start_date..end_date)
  end
end
