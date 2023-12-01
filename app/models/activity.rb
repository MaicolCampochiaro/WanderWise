require "open-uri"

class Activity < ApplicationRecord
  has_many :activity_statuses, dependent: :destroy
  has_many :trips, through: :activity_statuses

  validates :name, :description, :address, :date, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  has_one_attached :photo
  after_save if: -> { saved_change_to_name? || saved_change_to_ingredients? } do
    set_content
    set_photo
  end

  def content
    if super.blank?
      set_content
    else
      super
    end
  end

  private

  def set_content
    update(content: new_content)
    return new_content
  end

  def set_photo
    return photo
  end
end
