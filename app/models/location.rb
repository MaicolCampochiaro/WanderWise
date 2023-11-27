class Location < ApplicationRecord
  has_many :trips, dependent: :destroy
end
