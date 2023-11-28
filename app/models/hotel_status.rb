class HotelStatus < ApplicationRecord
  belongs_to :hotel
  belongs_to :trip

  validates :status, presence: true, format: { with: %w[planned done] }
end
