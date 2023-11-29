class FlightStatus < ApplicationRecord
  belongs_to :flight
  belongs_to :trip

  validates :adult, presence: true
  validates :status, presence: true, inclusion: { in: %w[planned done] }
end
