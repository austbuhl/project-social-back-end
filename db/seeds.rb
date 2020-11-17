require 'faker'
require 'geocoder'
require 'json'

# parks_file = File.read('./lib/seeds/parks.json')

# parks = JSON.parse(parks_file)
# parks.each do |park|
#   results = Geocoder.search(park['Name'])
#   coords = park['Coords'] ? park['Coords'] : results.first.coordinates
#   createdPark = Park.create(
#     name: park['Name'],
#     latitude: coords[0],
#     longitude: coords[1],
#     website: "http://www.nycgovparks.org/parks/#{park['Prop_ID']}/",
#     nycParkId: park['Prop_ID'],
#     location: park['Location']
#   )
#   puts createdPark
# end


user1 = User.create(username: 'test', password: 'test', email: 'test@test.com')
10.times do 
  User.create(username: Faker::Internet.username, password: Faker::Internet.password, email: Faker::Internet.email)
end


50.times do 
  Event.create(name: Faker::Coffee.blend_name , description: Faker::Coffee.notes , num_of_people: rand(20), datetime: DateTime.now + (rand * 21), park: Park.all.sample)
end

activities = ['Barbecue', 'Basketball', 'Bocce', 'Cricket', 'Handball', 'Kayaking', 'Tennis' ]

50.times do 
  Activity.create(name: activities.sample, park: Park.all.sample)
end

25.times do 
  EventActivity.create(event: Event.all.sample, activity: Activity.all.sample )
end

50.times do 
  UserEvent.create(user: User.all.sample, event: Event.all.sample)
end

50.times do 
  Comment.create(user: User.all.sample, event: Event.all.sample, text: Faker::Food.description)
end