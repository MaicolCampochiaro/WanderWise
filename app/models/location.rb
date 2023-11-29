class Location < ApplicationRecord
  has_many :trips, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true, uniqueness: true
end
