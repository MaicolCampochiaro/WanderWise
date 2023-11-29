class Hotel < ApplicationRecord
  has_many :hotel_statuses, dependent: :destroy

  validates :name, :description, :address, presence: true
end
