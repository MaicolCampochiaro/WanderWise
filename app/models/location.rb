class Location < ApplicationRecord
  has_many :trips, dependent: :destroy
  geocoded_by :address
  after_validation :geocode
  has_one_attached :photo

  validates :name, presence: true, uniqueness: true
end
