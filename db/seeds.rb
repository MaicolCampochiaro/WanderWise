puts 'Starting seed...'

10.times do
  location = Location.new(name: Faker::Address.city, address: Faker::Address.full_address)
  location.photo.attach(io: URI.open("https://picsum.photos/200/300?random=#{Faker::Number.number(digits: 4)}"), filename: 'fake_image.jpg')
  location.save!
end

5.times do
  flight = Flight.new(start_location: Faker::Address.city,
                      end_location: Faker::Address.city,
                      start_date: Faker::Date.between(from: '2023-11-29', to: '2023-12-02'),
                      end_date: Faker::Date.between(from: '2023-11-29', to: '2023-12-02'),
                      price: Faker::Number.number(digits: 3))
  flight.save!
end

puts 'Seed finished!'
