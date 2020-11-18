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

#   park_props = JSON.parse(File.read('data.json'))
  
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

parks = JSON.parse(File.read('output.json'))
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


# user1 = User.create(username: 'test', password: 'test', email: 'test@test.com')
# 10.times do 
#   User.create(username: Faker::Internet.username, password: Faker::Internet.password, email: Faker::Internet.email)
# end

# 50.times do 
#   Event.create(name: Faker::Coffee.blend_name , description: Faker::Coffee.notes , num_of_people: rand(20), datetime: DateTime.now + (rand * 21), park: Park.all.sample)
# end

activities = ['Barbecue', 'Basketball', 'Bocce', 'Cricket', 'Handball', 'Kayaking', 'Tennis' ]

50.times do 
  Activity.create(name: activities.sample, park: Park.all.sample)
end
artmap = JSON.parse(File.read('./lib/seeds/activities/DPR_ArtMonumentsMap_001.json'))


# 25.times do 
#   EventActivity.create(event: Event.all.sample, activity: Activity.all.sample )
# end

# 50.times do 
#   UserEvent.create(user: User.all.sample, event: Event.all.sample)
# end

# 50.times do 
#   Comment.create(user: User.all.sample, event: Event.all.sample, text: Faker::Food.description)
# end