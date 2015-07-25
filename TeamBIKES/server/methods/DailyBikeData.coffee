# Reserve
Meteor.methods 'UserReserveBike': (currentUserId, Bike) ->
  record = DailyBikeData.findOne({Bike: Bike})
  console.log 'Set tag for bike # ' + Bike
  DailyBikeData.update record, $set: Tag: currentUserId
  Bike