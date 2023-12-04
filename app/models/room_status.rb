class RoomStatus < ApplicationRecord
  belongs_to :hotel
  belongs_to :trip, optional: true

  validates :status, presence: true, inclusion: { in: %w[planned done] }
end
