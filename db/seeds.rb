puts 'Starting seed...'

10.times do
  Location.create(name: Faker::Address.city, address: Faker::Address.full_address)
end

puts 'Seed finished!'
