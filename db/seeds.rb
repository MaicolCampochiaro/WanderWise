require "cloudinary"
require "open-uri"
require 'json'
client = OpenAI::Client.new

Cloudinary.config do |config|
  config.cloud_name = ENV["CLOUDINARY_CLOUD_NAME"]
  config.api_key = ENV["CLOUDINARY_API_KEY"]
  config.api_secret = ENV["CLOUDINARY_API_SECRET"]
end

puts 'Starting seed for location...'

response = client.chat(parameters: {
  model: "gpt-3.5-turbo",
  messages: [
    { role: "system", content: "You are a helpful assistant that provides information about travel destinations." },
    { role: "user", content: 'Give me a list of the top 20 cities to visit in the world.
      Your response should be an array of objects.
      Each object should have the following structure:
      {"name": "string",
        "address": "string",
        "latitude": "float",
        "longitude": "float"}.
        Your answer should not include text like "Here are the top 20 locations."' }
  ]
})

# Extract the content from the GPT-3.5 response
locations_prompt = response["choices"][0]["message"]["content"]

# Use the generated prompt for further processing
locs = JSON.parse(locations_prompt)

2.times do
  location = Location.create!(locs.sample)

  # Attach an image to the location
  response = client.images.generate(parameters: {
    prompt: "An image of this location: #{location.name} that shows the city's landmarks.",
    size: "256x256"
  })

  url = response["data"][0]["url"]
  file = URI.open(url)

  location.photo.purge if location.photo.attached?
  location.photo.attach(io: file, filename: "ai_generated_image.jpg", content_type: "image/png")
  location.save!

  puts "Starting seed for activities in #{location.name}..."

  # Seed for activities
  response = client.chat(parameters: {
    model: "gpt-3.5-turbo",
    messages: [{
      role: "user",
      content: "give me 2 activities to do in '#{location.name}'.
      Your response should be an array of objects.
      Each object should have the following structure:
      {\"name\": \"string\",
        \"description\": \"string\",
        \"address\": \"string\",
        \"price\": \"float\"}.
        Your answer should not include text like 'Here are activities to do.'"
    }]
  })

  new_content = response["choices"][0]["message"]["content"]
  activities = JSON.parse(new_content)

  activities.each do |activity_data|

    activity = Activity.create!(
      name: activity_data["name"],
      description: activity_data["description"],
      address: activity_data["address"],
      price: activity_data["price"],
      location: location
    )

    # Create the image for the activity
    response = client.images.generate(parameters: {
      prompt: "An activity image of #{activity.name}",
      size: "256x256"
    })

    url = response["data"][0]["url"]
    file = URI.open(url)

    activity.photo.purge if activity.photo.attached?
    activity.photo.attach(io: file, filename: "ai_generated_image.jpg", content_type: "image/png")
    activity.save!
  end

  puts "activities seed finished!"

  puts "Starting seed for hotels in #{location.name}..."

  # Seed for hotels
  response = client.chat(parameters: {
    model: "gpt-3.5-turbo",
    messages: [{
      role: "user",
      content: "give me 2 real hotel  names to stay at in '#{location.name}' with unique names.
      Your response should be an array of objects.
      Each object should have the following structure:
      {\"name\": \"string\",
        \"description\": \"string\",
        \"address\": \"string\"}.
        Your answer should not include text like 'Here are hotels to stay in.'"
    }]
  })

  new_content = response["choices"][0]["message"]["content"]
  hotels_data = JSON.parse(new_content)

  hotels_data.each do |hotel_data|

    hotel = Hotel.create!(
      name: hotel_data["name"],
      description: hotel_data["description"],
      address: hotel_data["address"],
      location: location
    )

    # Create the image for the hotel
    response = client.images.generate(parameters: {
      prompt: "An hotel image of #{hotel.name}",
      size: "256x256"
    })

    url = response["data"][0]["url"]
    file = URI.open(url)

    hotel.photo.purge if hotel.photo.attached?
    hotel.photo.attach(io: file, filename: "ai_generated_image.jpg", content_type: "image/png")
    hotel.save!

    puts "Starting seed for rooms in #{hotel.name}..."

    # Seed for rooms
    3.times do
      RoomStatus.create!(room_name: Faker::Name.name, price: Faker::Number.number(digits: 3), status: "planned", hotel: hotel)
    end

  #   response = client.chat(parameters: {
  #     model: "gpt-3.5-turbo",
  #     messages: [{
  #       role: "user",
  #       content: "give me 2 real room names to stay at in '#{hotel.name}' with unique names like 'suite, single or double'.
  #       Your response should be an array of objects.
  #       Each object should have the following structure:
  #       {\"name\": \"string\",
  #         \"description\": \"string\",
  #         \"price\": \"float\"}.
  #         Your answer should not include text like 'Here are rooms to stay in.'"
  #     }]
  #   })

  #   new_content = response["choices"][0]["message"]["content"]
  #   rooms_data = JSON.parse(new_content)

  #   rooms_data.each do |room_data|

  #     room = RoomStatus.create!(
  #       room_name: room_data["name"],
  #       description: room_data["description"],
  #       price: room_data["price"],
  #       hotel: hotel
  #     )

  #     # Create the image for the room
  #     response = client.images.generate(parameters: {
  #       prompt: "An room image of #{room.name}",
  #       size: "256x256"
  #     })

  #     url = response["data"][0]["url"]
  #     file = URI.open(url)

  #     room.photo.purge if room.photo.attached?
  #     room.photo.attach(io: file, filename: "ai_generated_image.jpg", content_type: "image/png")
  #     room.save!
  #   end
  end
end

puts 'hotels seed finished!'

puts 'Starting seed for flights'

# 5.times do
#   flight = Flight.new(start_location: Faker::Address.city,
#                       end_location: Faker::Address.city,
#                       start_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now + 10),
#                       end_date: Faker::Date.between(from: Date.now - 1, to: Date.now + 10),
#                       price: Faker::Number.number(digits: 3))
#   flight.save!
# end

  puts 'flights seed finished'

  puts 'Seed finished!'
