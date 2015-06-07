# seeds/RedistributionCollection.coffee

# To help with load order, make sure there is DailyBikeData available
if DailyBikeData.find().count() != 0
  # If collection is empty
  if RedistributionCollection.find().count() == 0
    # Find all bikes
    BikeData = DailyBikeData.find().fetch()
    # Then strip out PII for redistribution access
    _.each BikeData, (BikeDatum) ->
      RedistributionCollection.insert
        Bike: BikeDatum.Bike
        Day: BikeDatum.Day
        Tag: BikeDatum.Tag
        # Make sure to strip out rider name
        Positions:
          Timestamp: BikeDatum.Positions[1].Timestamp
          Lat: BikeDatum.Positions[1].Lat
          Lng: BikeDatum.Positions[1].Lng
    console.log 'Created RedistributionCollection data schema'