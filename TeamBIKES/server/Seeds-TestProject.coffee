totalBikeCount = 200
# Calculate current day of year without momentjs
# Copied from: http://stackoverflow.com/questions/8619879/javascript-calculate-the-day-of-the-year-1-366

currentDay = ->
  dateFunc = new Date
  start = new Date(dateFunc.getFullYear(), 0, 0)
  diff = dateFunc - start
  oneDay = 1000 * 60 * 60 * 24
  day = Math.floor(diff / oneDay)
  day

now = (new Date).getTime()
# Bottom Right: Latitude : 38.980296 | Longitude : -76.933479
# Bottom Left: Latitude : 38.982297 | Longitude : -76.957941
# Top Left: Latitude : 38.999109 | Longitude : -76.956053
# Top Right: Latitude : 39.003778 | Longitude : -76.932278

randGPS = (max) ->
  # Calculate random GPS coordinates within campus
  leftLat = 38.994052
  rightLat = 38.981376
  bottomLng = -76.936569
  topLng = -76.950603
  skew = 1000000
  randLat = []
  randLng = []
  _.times max, ->
    randLat.push _.random(leftLat * skew, rightLat * skew) / skew
    return
  _.times max, ->
    randLng.push _.random(bottomLng * skew, topLng * skew) / skew
    return
  # Save in object to return
  randCoordinates =
    lat: randLat
    lng: randLng
  randCoordinates

# console.log(randGPS(25).lng[Math.round(24*Math.random())])
# console.log(randGPS(1).lng[0])
randNames = [
  'Anastasia Romanoff'
  'Marie Antoinette'
  'Chuff Chuffington'
  'Kate Middleton'
  'Harry Potter'
  'Snow White'
  'Lake Likesscooters'
  'Pippa Middleton'
  'Napoleon Bonapart'
  'Britany Bartsch'
  'Roselee Sabourin'
  'Chelsie Vantassel'
  'Chaya Daley'
  'Luella Cordon'
  'Jamel Brekke'
  'Jonie Schoemaker'
  'Susannah Highfield'
  'Mitzi Brouwer'
  'Forrest Lazarus'
  'Dortha Dacanay'
  'Delinda Brouse'
  'Alyssa Castenada'
  'Carlo Poehler'
  'Cicely Rudder'
  'Lorraine Galban'
  'Trang Lenart'
  'Patrica Quirk'
  'Zackary Dedios'
  'Ursula Kennerly'
  'Shameka Flick'
  'President Loh'
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
  ''
]

status = [
  'Scrap'
  'Waiting for Repair'
  'Fixed'
  'Fixed'
  'Fixed'
  'Fixed'
  'Available'
  'Available'
  'Available'
  'Available'
  'Available'
  'Available'
  'Available'
  'Available'
  'Available'
  'Available'
  'Available'
  'Available'
  'Available'
  'Available'
  'Available'
  'Available'
  'Available'
  'Available'
  'In Use'
  'In Use'
  'In Use'
  'In Use'
  'In Use'
  'In Use'
  'In Use'
  'In Use'
  'In Use'
]
partslist = [
  'Bottom Bracket'
  'Stacks of cash'
  'Stem post'
  'Handlebar'
]
mechanicNotes = [
  'Broken spokes, all of them'
  'Flat tire'
  'Broken stem'
  'Broken seatpost, someone was too heavy'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Tuneup'
  'Built from box'
  'Built from box'
]
mechanics = [
  {
    name: 'Erlene Pettit'
    role: 'Administrator'
  }
  {
    name: 'Ingrid Carney'
    role: 'Mechanic'
  }
  {
    name: 'Cassondra Chau'
    role: 'Mechanic'
  }
  {
    name: 'Katharina Pearce'
    role: 'Mechanic'
  }
  {
    name: 'Thomasina Dye'
    role: 'Mechanic'
  }
  {
    name: 'Melda Miranda'
    role: 'Mechanic'
  }
  {
    name: 'Doretha Bayne'
    role: 'Mechanic'
  }
  {
    name: 'Ester Newkirk'
    role: 'Mechanic'
  }
  {
    name: 'Wynell Rosa'
    role: 'Mechanic'
  }
  {
    name: 'Chadwick Slade'
    role: 'Mechanic'
  }
]

if BarChart.find().count() == 0
  console.log 'Starting BarChart with math!'
  randArray = []
  _.times 7, ->
    randArray.push _.random(10, 30)
    return
  BarChart.insert data: randArray

if AdminBarChart.find().count() == 0
  console.log 'Starting AdminBarChart with math!'
  randArray = []
  _.times 12, ->
    randArray.push _.random(40, 200)
    return
  AdminBarChart.insert
    name: '< 10 Minute Rides'
    data: randArray
  randArray = []
  _.times 12, ->
    randArray.push _.random(40, 200)
    return
  AdminBarChart.insert
    name: '10+ Minute Rides'
    data: randArray
  randArray = []
  _.times 12, ->
    randArray.push _.random(40, 200)
    return
  AdminBarChart.insert
    name: 'Off Campus Rides'
    data: randArray

if AdminAreaChart.find().count() == 0
  console.log 'Starting AdminAreaChart with math!'
  AdminAreaChart.insert
    name: 'Potentiometer Data'
    data: [ 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50 ]