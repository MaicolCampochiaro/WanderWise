class ActivityStatus < ApplicationRecord
  belongs_to :activity
  belongs_to :trip

  validates :status, presence: true
end
