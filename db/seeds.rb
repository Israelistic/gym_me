# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |n|
  u = User.new
  u.email = FFaker::Internet.email
  u.password = "passpass"
  u.first_name = FFaker::Name.first_name
  u.last_name = FFaker::Name.first_name
  u.fitness_level = rand(3)
  u.location = "#{rand(300)} King St. W"
  u.gender = "Male"
  u.description = FFaker::CheesyLingo.sentence
  u.matching = true
  u.time_of_day = ['Morning', 'Afternoon', 'Evening', 'Twilight'].sample
  u.day = Date::DAYNAMES.sample
  u.age = rand(100)
  u.save
end

5.times do |n|
  e = Event.new

  e.title = FFaker::Sport.name
  e.address = ["#{rand(500)} King St. W", "#{rand(500)} Yonge St.", "#{rand(400)} Queen St. E, Toronto, ON, Canada"].sample
  e.description = FFaker::CheesyLingo.sentence
  e.capacity = rand(10)
  e.activity_type = ["Yoga/Pilates", "Resistence Training", "Cardio", "Recreation"].sample

  e.user_id = (n+1)
  e.time = Time.now + 1000000
  e.persistence = false
  e.end_date = Time.now + 100000000000

  if e.activity_type == "Yoga/Pilates"
    e.activity_icon = "lotus-position.svg"
  elsif e.activity_type == "Resistence Training"
    e.activity_icon = "dumbbell.svg"
  elsif e.activity_type == "Cardio"
    e.activity_icon = "athletics.svg"
  else e.activity_type == "Recreation"
    e.activity_icon = "american-football.svg"
  end

  e.save!
end


5.times do |n|
  t = Ticket.new
  t.user_id = (5-n)
  t.event_id = (n+1)
  t.save!
  t.event.capacity -= 1
end
