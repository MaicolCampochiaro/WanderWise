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
  Location.create(locs.sample)
  # file = URI.open("https://picsum.photos/200/300?random=#{Faker::Number.number(digits: 4)}")
  # location.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  # location.save!
end

puts 'locations seed finished'
client = OpenAI::Client.new
Location.all.each do |location|
response = client.chat(parameters: {
  model: "gpt-3.5-turbo",
  messages: [{
    role: "user",
    content: "give me 5 activities to do in #{location.name}
    your response should be an array of objects. each objects should have the following structure:
    {name:string, description:string, address:string, date:datetime, price:float} 'Here are activities to do'."}]
})

new_content = response["choices"][0]["message"]["content"]
activities = JSON.parse(new_content)
activities.each do |activity|
  Activity.create(name: activity["name"], description: activity["description"], address: activity["address"], date: activity["date"], price: activity["price"], location: location)
end


response = client.images.generate(parameters: {
  prompt: "An activity image of #{activity.name}", size: "382x180"
})

url = response["data"][0]["url"]
file =  URI.open(url)

photo.purge if photo.attached?
photo.attach(io: file, filename: "ai_generated_image.jpg", content_type: "image/png")

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

  puts 'Starting seed for hotels'

  5.times do
    hotel = Hotel.new(
      name: Faker::Company.name,
      description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
      address: Faker::Address.full_address
    )
    file = URI.open("https://picsum.photos/200/300?random=#{Faker::Number.number(digits: 4)}")
    hotel.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
    hotel.save!
  end

  puts 'hotels seed finished'

puts 'Seed finished!'
