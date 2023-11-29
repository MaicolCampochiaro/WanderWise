require "cloudinary"
require "open-uri"

Cloudinary.config do |config|
  config.cloud_name = ENV["CLOUDINARY_CLOUD_NAME"]
  config.api_key = ENV["CLOUDINARY_API_KEY"]
  config.api_secret = ENV["CLOUDINARY_API_SECRET"]
end

puts 'deleting old seeds...'

# Delete existing data
User.delete_all
Location.delete_all

puts 'end of deletion...'

puts 'Starting seed for location...'

10.times do
  location = Location.new(name: Faker::WorldCup.city, address: Faker::Address.full_address)

  file = URI.open("https://picsum.photos/200/300?random=#{Faker::Number.number(digits: 4)}")
  location.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  location.save!
end

puts 'Location seed finished!'
