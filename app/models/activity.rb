class Activity < ApplicationRecord
  has_many :activity_statuses, dependent: :destroy
  has_many :trips, through: :activity_statuses

  validates :name, :description, :address, :date, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  has_one_attached :photo

  def content
    Rails.cache.fetch("#{cache_key_with_version}/content") do
      client = OpenAI::Client.new
      chaptgpt_response = client.chat(parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: ""}]
      })
      chaptgpt_response["choices"][0]["message"]["content"]
    end
  end
end
