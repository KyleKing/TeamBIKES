# server/publications/DailyBikeData.coffee

# Give authorized users access to sensitive data by group
Meteor.publish 'DailyBikeDataPub', (group) ->
  if Roles.userIsInRole(@userId, ['Admin', 'Root'], group)
    DailyBikeData.find()
  else
    # user not authorized. do not publish DailyBikeData
    @stop()

Meteor.publish "ManageBikes", ->
  DailyBikeData.find({Tag: {$ne: "Removed"}}, {fields: {Positions: 0}})