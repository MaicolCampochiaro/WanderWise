require "open-uri"
class Activity < ApplicationRecord
  has_many :activity_statuses, dependent: :destroy
  has_many :trips, through: :activity_statuses
  belongs_to :location
  geocoded_by :address
  after_validation :geocode

  validates :name, :description, :address, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  has_one_attached :photo
end
