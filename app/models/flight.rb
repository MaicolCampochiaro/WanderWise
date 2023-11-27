class Flight < ApplicationRecord
  has_many :flight_statuses, dependent: :destroy
end
