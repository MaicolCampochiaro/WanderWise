class ActivityStatus < ApplicationRecord
  belongs_to :activity
  belongs_to :trip

  validates :participant, presence: true
  validates :status, presence: true, format: { with: %w[planned done] }
end
