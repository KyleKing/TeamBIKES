Meteor.methods 'Delete_Users': ->
  Meteor.users.remove({ 'profile.UID': { $lte:  999999999} })

Meteor.methods 'Delete_DailyBikeData': ->
  [today, now] = CurrentDay()
  # DailyBikeData.remove({ Day: { $lt:  today+1} })
  DailyBikeData.remove({ Day: { $gte:  today} })

Meteor.methods 'Delete_RackNames': ->
  [today, now] = CurrentDay()
  # DailyBikeData.remove({ Day: { $lt:  today} })
  console.warn 'No data to delete'
  'ok'

Meteor.methods 'Delete_OuterLimit': ->
  [today, now] = CurrentDay()
  # DailyBikeData.remove({ Day: { $lt:  today} })
  console.warn 'No data to delete'
  'ok'

Meteor.methods 'Delete_RFIDdata': ->
  [today, now] = CurrentDay()
  RFIDdata.remove({ TIMESTAMP: { $lte:  now} })
