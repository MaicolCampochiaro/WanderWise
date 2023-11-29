class HotelStatus < ApplicationRecord
  belongs_to :hotel
  belongs_to :trip

  validates :status, presence: true, inclusion: { in: %w[planned done] }
end
