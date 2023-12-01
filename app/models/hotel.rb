class Hotel < ApplicationRecord
  has_many :hotel_statuses, dependent: :destroy
  belongs_to :location

  validates :name, :description, :address, presence: true
  has_one_attached :photo
end
