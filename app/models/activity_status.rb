class ActivityStatus < ApplicationRecord
  belongs_to :activity
  belongs_to :trip

  validates :participant, presence: true
  validates :status, presence: true, format: { in: %w[planned done] }
end
