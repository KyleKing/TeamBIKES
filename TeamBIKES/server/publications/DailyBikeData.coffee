# server/publications/MeteorUsers.coffee

# Give authorized users access to sensitive data by group
# Includes PII like login names, emails and roles
Meteor.publish null, (group) ->
  if Roles.userIsInRole(@userId, ['Admin'], group)
    DailyBikeData.find()
  else
    # user not authorized. do not publish DailyBikeData
    @stop()
    return

# Note list of all available roles: Meteor.roles