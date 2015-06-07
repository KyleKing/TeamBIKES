# server/publications/DailyBikeData.coffee

# Give authorized users access to sensitive data by group
# Published as null so no subscription call unnecessary, for now
Meteor.publish null, (group) ->
  if Roles.userIsInRole(@userId, ['Admin', 'Root'], group)
    DailyBikeData.find()
  else
    # user not authorized. do not publish DailyBikeData
    @stop()
    return