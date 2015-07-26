# Reserve a bike
Meteor.methods 'UserReserveBike': (currentUserId, Bike) ->
  # Check if other reserved bikes and remove reservations
  count = DailyBikeData.find({Tag: currentUserId}).count()
  DailyBikeData.update { Tag: currentUserId}, {$set: Tag: 'Available' }, multi: true

  # Find and reserve requested bike
  record = DailyBikeData.findOne({Bike: Bike})
  if record
    DailyBikeData.update record, {$set: {Tag: currentUserId} }
    console.log 'Set tag for bike # ' + Bike
  count