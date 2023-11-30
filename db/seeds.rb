require "cloudinary"
require "open-uri"
require 'json'

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

locs = []
File.open('db/locations.json') do |file|
  locs = JSON.parse(file.read)
end

10.times do
  location = Location.new(locs.sample)

  file = URI.open("https://picsum.photos/200/300?random=#{Faker::Number.number(digits: 4)}")
  location.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  location.save!
end

puts 'locations seed finished'

puts 'Starting seed for flights'

5.times do
  flight = Flight.new(start_location: Faker::Address.city,
                      end_location: Faker::Address.city,
                      start_date: Faker::Date.between(from: '2023-11-29', to: '2023-12-02'),
                      end_date: Faker::Date.between(from: '2023-11-29', to: '2023-12-02'),
                      price: Faker::Number.number(digits: 3))
  flight.save!
end

puts 'flights seed finished'

puts 'Seed finished!'
