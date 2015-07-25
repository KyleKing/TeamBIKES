# server/publications/DailyBikeData.coffee

# Give authorized users access to sensitive data by group
Meteor.publish 'DailyBikeDataPub', (group) ->
  if Roles.userIsInRole(@userId, ['Admin', 'Root'], group)
    DailyBikeData.find()
  else
    # user not authorized. do not publish DailyBikeData
    @stop()


Meteor.publish 'AvailableBikeLocationsPub', ->
	DailyBikeData.find {Tag: 'Available'}, fields: Positions: 0
Meteor.publish 'ReservedBike', ->
	console.log @userId
	DailyBikeData.find {Tag: @userId}, fields: Positions: 0

Meteor.publish "ManageBikes", ->
  DailyBikeData.find({Tag: {$ne: "Removed"}}, {fields: {Positions: 0}})