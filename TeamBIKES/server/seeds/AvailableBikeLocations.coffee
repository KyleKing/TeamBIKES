# seeds/AvailableBikeLocations.coffee

# To help with load order, make sure there is DailyBikeData available
[today, now] = CurrentDay()
if DailyBikeData.find({Day: today}).count() != 0
  # If collection is empty
  if AvailableBikeLocations.find({Day: today}).count() == 0
    # Remove old data and update with current day data only
    AvailableBikeLocations.remove({Day: {$gt: 0} });
    # Find all bikes with the Tag: 'Available' in today's collection
    BikeData = DailyBikeData.find({Day: today, Tag: 'Available'}).fetch()
    # Insert the most recent information into a collection for user access
    _.each BikeData, (BikeDatum) ->
      AvailableBikeLocations.insert
        Bike: BikeDatum.Bike
        Day: BikeDatum.Day
        Tag: 'Available'
        # Make sure to strip out rider name and only take last position
        ## WIP
        ## not from a sorted array -> need to pick latest update
        Timestamp: BikeDatum.Positions[0].Timestamp
        Lat: BikeDatum.Positions[0].Lat
        Lng: BikeDatum.Positions[0].Lng
        ## WIP
    console.log 'Created AvilableBikeData data schema'