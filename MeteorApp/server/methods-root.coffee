Meteor.methods 'Delete_Users': ->
  if Meteor.userId()
    ID = Meteor.userId()
  else
    ID = 'fakeID'
  Meteor.users.remove({ $and: [
    { 'profile.UID': { $lte:  999999999 } },
    { _id: { $ne:  ID } }
  ] })

Meteor.methods 'Delete_DailyBikeData': ->
  [today, now] = CurrentDay()
  DailyBikeData.remove({ Day: { $lte:  today} })
  # DailyBikeData.remove({ Day: { $gte:  today} })

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

Meteor.methods 'Delete_RFIDtags': ->
  [today, now] = CurrentDay()
  RFIDtags.remove({ TIMESTAMP: { $lte:  now} })

Meteor.methods 'Delete_MechanicNotes': ->
  [today, now] = CurrentDay()
  MechanicNotes.remove({ Timestamp: { $lte:  now} })

Meteor.methods 'Delete_XbeeData': ->
  [today, now] = CurrentDay()
  XbeeData.remove({ TIMESTAMP: { $lte:  now} })
