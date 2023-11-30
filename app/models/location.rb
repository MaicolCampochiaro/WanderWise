class Location < ApplicationRecord
  has_many :trips, dependent: :destroy
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  has_one_attached :photo

  # validates :name, presence: true, uniqueness: true
end
