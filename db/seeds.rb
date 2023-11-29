puts 'Starting seed...'

10.times do
  location = Location.new(name: Faker::Address.city, address: Faker::Address.full_address)
  location.photo.attach(io: URI.open("https://picsum.photos/200/300?random=#{Faker::Number.number(digits: 4)}"), filename: 'fake_image.jpg')
  location.save!
end

puts 'Seed finished!'
