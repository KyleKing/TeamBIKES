# MUST be run last (that's why there is the z)

# Seed the entire fake database using these methods:
[today, now] = CurrentDay()
if DailyBikeData.find({Day: today}).count() is 0
  Meteor.call('CreateDailyBikeData', 200, 2)

if Meteor.users.find().count() is 0
  Meteor.call('Create_Users')

if RFIDtags.find().count() is 0
  Meteor.call('Create_RFIDtags')

Meteor.call('Create_XbeeData')

if RackNames.find().count() is 0
  Meteor.call('Create_RackNames')

# Call mechanic notes because dependent on a set list of users:
Meteor.call('Create_MechanicNotes')

# Dependent on DailyBikeData:
if OuterLimit.find().count() is 0
  Meteor.call('Create_OuterLimit')

# Filler Chart data (unsorted)
Meteor.call('Create_TestProject')

# For troubleshooting the Raspberry Pi connection
Meteor.call('Create_ReservationEvents')

console.log 'Completed seeds-z-init.coffee tasks in order'.lightYellow
