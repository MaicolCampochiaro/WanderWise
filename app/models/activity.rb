class Activity < ApplicationRecord
  has_many :activity_statuses, dependent: :destroy
  has_many :trips, through: :activity_statuses

  validates :name, :description, :address, :date, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  has_one_attached :photo
end
