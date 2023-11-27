class Hotel < ApplicationRecord
  has_many :hotel_statuses, dependent: :destroy
end
