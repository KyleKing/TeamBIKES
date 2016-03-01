Meteor.methods 'Create_DailyBikeData': ->
  Meteor.call('CreateDailyBikeData', 50, 1)

Meteor.methods 'CreateDailyBikeData': (NumBikes, NumDays) ->
  [today, now] = CurrentDay()

  # DailyBikeData {
  #   Bike: <number>,
  #   Day: <number out of 365>,
  #   Tag: <ToBeRedistributed, RepairToBeStarted,
  #       RepairInProgress, WaitingOnParts, Available>
  #   Positions: [{
  #     TS: <timestamp>,
  #     Rider: <None, User ID, or Employee ID>,
  #     Lat: 38.991403,
  #     Lng: -76.941449
  #   }, ...]
  # }

  # # Run asynchronously
  # @unblock()

  console.log 'Started creating DailyBikeData data schema'
  j = 0
  while j < NumDays
    if DailyBikeData.find({Day: (today - j) }).count() is 0
      i = 1
      while i <= NumBikes
        dbd = new DailyBikeDatum()
        # create template for each DailyBikeData data stored
        Position = []
        randomNow = NaN
        blank = {}
        countTime = 0

        TotalBikes = DailyBikeData.find().count()
        if TotalBikes is 0
          BikeCount = i
        else
          BikeCount = TotalBikes + 1
        dbd.set(
          Bike: BikeCount
          Day: today - j
          Tag: myUtilities.randTag()
          Coordinates: myUtilities.randGPS(1)
        )
        while countTime < 30
          # For 60 minutes in an hour
          randomNow = now - (10000000 * Math.random())
          RandTag = myUtilities.randTag()
          dbd.push('Positions',
            Tag: RandTag
            Rider: if RandTag is 'rndtag' then myUtilities.randName() else ''
            Timestamp: randomNow
            Coordinates: myUtilities.randGPS(1)
          )
          countTime++
        dbd.save()
        i++
      console.log 'Created DailyBikeData for ' + j + ' days behind today'
    j++
  console.log 'CreateDailyBikeData: Done generating random DailyBikeData data'.yellow

  # Inform the Creator (Kyle)
  info = 'CreateDailyBikeData finished. Currently ' +
    DailyBikeData.find({Day: today}).count() +
    ' bikes were found.'
  Meteor.call('sendEmailUpdate', 'Hello from Meteor!', info)
