class Location < ApplicationRecord
  has_many :trips, dependent: :destroy
  has_one_attached :photo
end
