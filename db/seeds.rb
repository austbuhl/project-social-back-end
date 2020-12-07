require 'faker'
require 'byebug'
require 'geocoder'
require 'json'
require 'csv'


# File.open("output.json", "w") do |f|     
#   parks = JSON.parse(File.read('./lib/seeds/parks.json'))
#   playgrounds = JSON.parse(File.read('./lib/seeds/activities/DPR_Playgrounds_001.json'))
#   bball = JSON.parse(File.read('./lib/seeds/activities/DPR_Basketball_001.json'))
#   handball = JSON.parse(File.read('./lib/seeds/activities/DPR_Handball_001.json'))
#   art = JSON.parse(File.read('./lib/seeds/activities/DPR_ArtMonumentsMap_001.json'))
#   pools = JSON.parse(File.read('./lib/seeds/activities/DPR_Pools_outdoor_001.json'))
#   tennis = JSON.parse(File.read('./lib/seeds/activities/DPR_Tennis_001.json'))

#   park_props = JSON.parse(File.read('./lib/seeds/parks_properties.json'))
  
#   updatedParks = parks.map do |park|
#     playground_match = playgrounds.find{|play| play['Prop_ID'] == park['Prop_ID']}
#     bball_match = bball.find{|ball| ball['Prop_ID'] == park['Prop_ID']}
#     handball_match = handball.find{|hand| hand['Prop_ID'] == park['Prop_ID']}
#     art_match = art.find{|mon| mon['Prop_ID'] == park['Prop_ID']}
#     pool_match = pools.find{|pool| pool['Prop_ID'] == park['Prop_ID']}
#     tennis_match = tennis.find{|court| court['Prop_ID'] == park['Prop_ID']}
#     park_match = park_props.find{|prop| prop['OMPPROPID'] == park['Prop_ID']}

#     if park['Coords']
#       coords = park['Coords']
#     elsif playground_match
#       coords = [playground_match['lat'], playground_match['lon']]
#     elsif bball_match
#       coords = [bball_match['lat'], bball_match['lon']]
#     elsif handball_match
#       coords = [handball_match['lat'], handball_match['lon']]
#     elsif art_match
#       coords = [art_match['lat'], art_match['lon']]
#     elsif pool_match
#       coords = [pool_match['lat'], pool_match['lon']]
#     elsif tennis_match
#       coords = [tennis_match['lat'], tennis_match['lon']]
#     elsif park_match
#       lookup = {:B =>'Brooklyn', :M => 'Manhattan', :Q => 'Queens', :R => 'Staten Island', :X=> 'Bronx'}
#       key = park['Prop_ID'][0]
#       borough = lookup[key.to_sym]
#       address = "#{park_match['ADDRESS'] || park_match['SIGNNAME']}, #{borough}, NY"
#       results = Geocoder.search(address)
#       coords = results.length > 0 ? results.first.coordinates : [0,0]
#     else
#       coords = [0, 0]
#     end

#     {
#       name: park['Name'],
#       latitude: coords[0],
#       longitude: coords[1],
#       website: "http://www.nycgovparks.org/parks/#{park['Prop_ID']}/",
#       nycParkId: park['Prop_ID'],
#       location: park['Location']
#     }
#   end
#   f.write(updatedParks.to_json)   
# end



# csv_table = CSV.parse(File.read('./lib/seeds/Parks_Properties.csv'), headers: true)
# json_string = csv_table.map(&:to_h).to_json

# File.open('data.json','w') do |f|
#   f.puts(json_string)
# end



# parks_file = File.read('./lib/seeds/parks.json')

Park.destroy_all
EventActivity.destroy_all
UserEvent.destroy_all
Activity.destroy_all
User.destroy_all
Comment.destroy_all
Event.destroy_all
Friendship.destroy_all

parks = JSON.parse(File.read('./lib/seeds/output.json'))
parks.each do |park|
  createdPark = Park.create(
    name: park['name'],
    latitude: park['latitude'],
    longitude: park['longitude'],
    website: "http://www.nycgovparks.org/parks/#{park['nycParkId']}/",
    nycParkId: park['nycParkId'],
    location: park['location']
  )
  puts createdPark
end


# Faker::Internet.username
austin = User.create(username: 'Austin', password: 'Austin')
100.times do 
  User.create(username: Faker::FunnyName.name, password: Faker::Internet.password)
end

1000.times do 
  Event.create(name: Faker::Coffee.blend_name , description: Faker::Coffee.notes.capitalize , num_of_people: rand(20), date: Date.today + (rand * 21), time:Time.at(rand * Time.now.to_i).strftime('%H:%M'), park: Park.all.sample)
end



artmap = JSON.parse(File.read('./lib/seeds/activities/DPR_ArtMonumentsMap_001.json'))
artmap.each do |art|
  parkId = art['parks'].length > 0 ? art['parks'].keys[0] : nil
  park = Park.find_by(nycParkId: parkId)
  
  if(park)
    Activity.create(name: art['type'].capitalize, park: park, addl_detail: "#{art['name']} - https://www.nycgovparks.org#{art['link']}")
  end
end

bbq = JSON.parse(File.read('./lib/seeds/activities/DPR_Barbecue_001.json'))
bbq.each do |q|
  park = Park.find_by(nycParkId: q['Prop_ID'])
  if(park)
    Activity.create(name: 'Barbecue', park: park, addl_detail: q['Location'])
  end
end

bball = JSON.parse(File.read('./lib/seeds/activities/DPR_Basketball_001.json'))
bball.each do |ball|
  park = Park.find_by(nycParkId: ball['Prop_ID'])
  if(park)
    Activity.create(name: 'Basketball', park: park, addl_detail: ball['Num_of_Courts'])
  end
end

beaches = JSON.parse(File.read('./lib/seeds/activities/DPR_Beaches_001.json'))
beaches.each do |beach|
  park = Park.find_by(nycParkId: beach['Prop_ID'])
  if(park)
    Activity.create(name: 'Beach', park: park, addl_detail: beach['Description'])
  end
end

bocce = JSON.parse(File.read('./lib/seeds/activities/DPR_Bocce_001.json'))
bocce.each do |b|
  park = Park.find_by(nycParkId: b['Prop_ID'])
  if(park)
    Activity.create(name: 'Bocce', park: park, addl_detail: nil)
  end 
end

cricket = JSON.parse(File.read('./lib/seeds/activities/DPR_Cricket_001.json'))
cricket.each do |c|
  park = Park.find_by(nycParkId: c['Prop_ID'])
  if(park)
    Activity.create(name: 'Cricket', park: park, addl_detail: c['Num_of_Fields'])
  end
end

dogs = JSON.parse(File.read('./lib/seeds/activities/DPR_DogRuns_001.json'))
dogs.each do |d|
  park = Park.find_by(nycParkId: d['Prop_ID'])
  if(park)
    Activity.create(name: 'Dog Run', park: park, addl_detail: d['DogRuns_Type'])
  end
end

hands = JSON.parse(File.read('./lib/seeds/activities/DPR_Handball_001.json'))
hands.each do |hand|
  park = Park.find_by(nycParkId: hand['Prop_ID'])
  if(park)
    Activity.create(name: 'Handball', park: park, addl_detail: hand['Num_of_Courts'])
  end
end

hiking = JSON.parse(File.read('./lib/seeds/activities/DPR_Hiking_001.json'))
hiking.each do |hike|
  park = Park.find_by(nycParkId: hike['Prop_ID'])
  if(park)
    Activity.create(name: 'Hiking', park: park, addl_detail: "Length: #{hike['Length']} - Difficulty: #{hike['Difficulty']}")
  end
end

horses = JSON.parse(File.read('./lib/seeds/activities/DPR_Horseback_001.json'))
horses.each do |horse|
  park = Park.find_by(nycParkId: horse['Prop_ID'])
  if(park)
    Activity.create(name: 'Horseback Riding', park: park, addl_detail: horse['Description'])
  end
end

skating = JSON.parse(File.read('./lib/seeds/activities/DPR_IceSkating_001.json'))
skating.each do |skate|
  park = Park.find_by(nycParkId: skate['Prop_ID'])
  if(park)
    Activity.create(name: 'Ice Skating', park: park, addl_detail: skate['IceSkating_Type'])
  end
end

kayaking = JSON.parse(File.read('./lib/seeds/activities/DPR_Kayak_001.json'))
kayaking.each do |kayak|
  park = Park.find_by(nycParkId: kayak['Prop_ID'])
  if(park)
    Activity.create(name: 'Kayaking', park: park, addl_detail: kayak['Hours'])
  end
end

natcenters = JSON.parse(File.read('./lib/seeds/activities/DPR_NatureCenters_001.json'))
natcenters.each do |nat|
  park = Park.find_by(nycParkId: nat['Prop_ID'])
  if(park)
    Activity.create(name: 'Nature Center', park: park, addl_detail: nat['Hours'])
  end
end

natpreserve = JSON.parse(File.read('./lib/seeds/activities/DPR_NaturePreserves_001.json'))
natpreserve.each do |nat|
  park = Park.find_by(nycParkId: nat['ParkID'])
  if(park)
    Activity.create(name: 'Nature Preserve', park: park, addl_detail: nat['Description'])
  end
end

playgrounds = JSON.parse(File.read('./lib/seeds/activities/DPR_Playgrounds_001.json'))
playgrounds.each do |pg|
  park = Park.find_by(nycParkId: pg['Prop_ID'])
  if(park)
    Activity.create(name: 'Playground', park: park, addl_detail: pg['Level'])
  end
end

indoor_pools = JSON.parse(File.read('./lib/seeds/activities/DPR_Pools_indoor_001.json'))
indoor_pools.each do |pool|
  park = Park.find_by(nycParkId: pool['Prop_ID'])
  if(park)
    Activity.create(name: 'Indoor Pool', park: park, addl_detail: pool['Pools_indoor_Type'])
  end
end

outdoor_pools = JSON.parse(File.read('./lib/seeds/activities/DPR_Pools_outdoor_001.json'))
outdoor_pools.each do |pool|
  park = Park.find_by(nycParkId: pool['Prop_ID'])
  if(park)
    Activity.create(name: 'Outdoor Pool', park: park, addl_detail: pool['Pools_outdoor_Type'])
  end
end

tracks = JSON.parse(File.read('./lib/seeds/activities/DPR_RunningTracks_001.json'))
tracks.each do |track|
  park = Park.find_by(nycParkId: track['Prop_ID'])
  if(park)
    Activity.create(name: 'Running Track', park: park, addl_detail: "#{track['RunningTracks_Type']} - #{track['Size']}")
  end
end

tennis = JSON.parse(File.read('./lib/seeds/activities/DPR_Tennis_001.json'))
tennis.each do |court|
  park = Park.find_by(nycParkId: court['Prop_ID'])
  if(park)
    Activity.create(name: 'Tennis', park: park, addl_detail: court['Indoor_Outdoor'])
  end
end

zoos = JSON.parse(File.read('./lib/seeds/activities/DPR_Zoos_001.json'))
zoos.each do |zoo|
  park = Park.find_by(nycParkId: zoo['Prop_ID'])
  if(park)
    Activity.create(name: 'Zoo', park: park, addl_detail: nil)
  end
end


1000.times do 
  event = Event.all.sample
  activities = event.park.activities
  EventActivity.create(event: event, activity: activities.sample )
end

1000.times do 
  UserEvent.create(user: User.all.sample, event: Event.all.sample)
end

1000.times do 
  event = Event.all.sample
  user = event.users
  Comment.create(user: user.sample, event: event, text: Faker::TvShows::MichaelScott.quote)
end

5.times do 
  event = Event.find(1001)
  user = event.users
  Comment.create(user: user.sample, event: event, text: Faker::TvShows::MichaelScott.quote)
end

250.times do 
  user1 = User.all.sample.id
  user2 = User.all.sample.id
  Friendship.friend_request(user1, user2)
end

5.times do 
  Friendship.friend_request(1, User.all.sample.id)
end

5.times do
  Friendship.friend_request(User.all.sample.id, 1)
end


25.times do 
  UserEvent.create(user: austin, event: Event.all.sample)
end

# 50.times do 
#   event = austin.events.sample
#   # user = event.users
#   Comment.create(user: austin, event: event, text: Faker::TvShows::MichaelScott.quote)
# end

## Faker::Marketing.buzzwords #=> "rubber meets the road", "sprint to the finish line"
## Faker::Company.catch_phrase #=> "Business-focused coherent parallelism"

## for comments ? Faker::Hacker.say_something_smart #=> "Try to compress the SQL interface, maybe it will program the back-end hard drive!"
## more comments Faker::ChuckNorris.fact #=> "Chuck Norris can solve the Towers of Hanoi in one move."
## Faker::TvShows::MichaelScott.quote #=> "I am Beyoncé, always."

# Faker::Subscription.payment_term #=> "Monthly"
# Faker::Music.album #=> "Sgt. Pepper's Lonely Hearts Club"
