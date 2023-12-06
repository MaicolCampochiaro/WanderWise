class Hotel < ApplicationRecord
  has_many :room_statuses, dependent: :destroy
  belongs_to :location

  validates :name, :description, :address, presence: true
  has_one_attached :photo
end
