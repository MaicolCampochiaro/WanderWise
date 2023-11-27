class Activity < ApplicationRecord
  has_many :activity_statuses, dependent: :destroy
end
