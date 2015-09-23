# Fetch Bike Rack Locations from UMD API
Meteor.methods 'CreateDailyBikeData': ->
  console.log 'called method for CreateDailyBikeData'
  # DailyBikeData {
  #   Bike: <number>,
  #   Day: <number out of 365>,
  #   Tag: <ToBeRedistributed, RepairToBeStarted, RepairInProgress, WaitingOnParts, Available>
  #   Positions: [{
  #     TS: <timestamp>,
  #     Rider: <None, User ID, or Employee ID>,
  #     Lat: 38.991403,
  #     Lng: -76.941449
  #   }, ...]
  # }

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
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''
  ]
  AllRandNames = [
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
  ]

  # Bottom Right: Latitude : 38.980296 | Longitude : -76.933479
  # Bottom Left: Latitude : 38.982297 | Longitude : -76.957941
  # Top Left: Latitude : 38.999109 | Longitude : -76.956053
  # Top Right: Latitude : 39.003778 | Longitude : -76.932278
  # randGPS = (max) ->
    # # Calculate random GPS coordinates within campus
    # leftLat = 38.994052
    # rightLat = 38.981376
    # bottomLng = -76.936569
    # topLng = -76.950603
    # skew = 1000000
    # randLat = []
    # randLng = []
    # _.times max, ->
    #   randLat.push _.random(leftLat * skew, rightLat * skew) / skew
    #   return
    # _.times max, ->
    #   randLng.push _.random(bottomLng * skew, topLng * skew) / skew
    #   return
    # # Save in object to return
    # randCoordinates =
    #   Lat: randLat
    #   Lng: randLng
    # randCoordinates
  randGPS = () ->
    RandID = _.random(1, RackNames.find().count())
    RackNames.findOne({'attributes.OBJECTID': RandID}).Coordinates


  # Useful function from lib/CurrentDay.coffee for current date and time
  [today, now] = CurrentDay()
  # Insert database of bikes if no data for today
  if DailyBikeData.find({Day: today}).count() is 0 and RackNames.find().count() isnt 0
    console.log 'Started creating DailyBikeData data schema'
    j = 0
    while j < 4
      if DailyBikeData.find({Day: (today-j) }).count() is 0
        i = 1
        while i <= 100
          # create template for each DailyBikeData data stored
          Position = []
          randomNow = NaN
          blank = {}
          countTime = 0
          while countTime < 30
            # For 60 minutes in an hour
            randomNow = now - (10000000 * Math.random())
            namePoint = Math.round((randNames.length - 1) * Math.random())
            # console.log('randNames = ' + randNames);
            if Math.round(0.75 * Math.random()) is 0
              if Math.round(1.1 * Math.random()) is 0
                RandTag = 'asdfahdfghsdlkfjsad'
              else
                RandTag = 'Available'
            else
              RandTag = 'RepairInProgress'
            blank =
              Tag: RandTag
              Rider: if RandTag is 'asdfahdfghsdlkfjsad' then AllRandNames[namePoint] else ''
              Timestamp: randomNow
              Coordinates: randGPS()
            # console.log('name = ' + blank.User);
            Position.push blank
            countTime++
          DailyBikeData.insert
            Bike: i
            Day: today - j
            # simplified version
            Tag: RandTag
            Coordinates: randGPS()
            Positions: Position
          i++
        console.log 'Created DailyBikeData data schema for ' + j + ' days behind today'
      j++
    console.log 'Done creating DailyBikeData data schema'