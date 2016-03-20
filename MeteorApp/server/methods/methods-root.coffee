Meteor.methods 'Delete_Users': ->
  if Meteor.userId()
    ID = Meteor.userId()
  else
    ID = 'fakeID'
  Meteor.users.remove( {'_id': { $ne:  ID }} )
  # console.log 'Count: ' + Meteor.users.find().count()

Meteor.methods 'Delete_DailyBikeData': ->
  [today, now] = CurrentDay()
  # DailyBikeData.remove({ 'Day': { $lte:  today} })
  DailyBikeData.remove({ 'Tag': { $ne:  'klb'} })
  # Delete only most recent data:
  # DailyBikeData.remove({ Day: { $gte:  today} })

Meteor.methods 'Delete_RackNames': ->
  RackNames.remove({ $or: [
    { 'Availability': { $lt: Math.exp(10, 10) }},
    { 'Availability': { $eq: null }}
  ]})

Meteor.methods 'Delete_OuterLimit': ->
  OuterLimit.remove({ $or: [
    { 'attributes.OBJECTID': { $lt: Math.exp(10, 10) }},
    { 'attributes.OBJECTID': { $eq: null }}
  ]})

Meteor.methods 'Delete_RFIDtags': ->
  [today, now] = CurrentDay()
  RFIDtags.remove({ TIMESTAMP: { $lte:  now} })

Meteor.methods 'Delete_MechanicNotes': ->
  [today, now] = CurrentDay()
  MechanicNotes.remove({ Timestamp: { $lte:  now} })

Meteor.methods 'Delete_XbeeData': ->
  [today, now] = CurrentDay()
  XbeeData.remove({ TIMESTAMP: { $lte:  now} })

Meteor.methods 'Delete_TestProject': ->
  RandMechanicNames.remove({ 'deleteFilter': { $lte:  2} })
  BarChart.remove({ 'deleteFilter': { $lte:  2} })
  AdminBarChart.remove({ 'deleteFilter': { $lte:  2} })
  AdminAreaChart.remove({ 'deleteFilter': { $lte:  2} })
  TestProject.remove({ 'deleteFilter': { $lte:  2} })
