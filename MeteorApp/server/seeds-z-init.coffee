[today, now] = CurrentDay()
if DailyBikeData.find({Day: today}).count() is 0
  Meteor.call('CreateDailyBikeData', 10, 4)

if Meteor.users.find().count() is 0
  Meteor.call('Create_Users')

if RFIDtags.find().count() is 0
  Meteor.call('Create_RFIDtags')

Meteor.call('Create_XbeeData')

# Call mechanic notes because dependent on a set list of users:
Meteor.call('Create_MechanicNotes')

# Meteor.call('TestProject')
