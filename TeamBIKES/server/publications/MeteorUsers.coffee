# server/publications/MeteorUsers.coffee

# Give authorized users access to sensitive data by group
# Includes PII like login names, emails and roles
Meteor.publish 'UsersPub', (group) ->
  if Roles.userIsInRole(@userId, ['Admin', 'Mechanic', 'Root'], group)
    Meteor.users.find()
  else
    # user not authorized. do not publish secrets
    @stop()
    return

# Note list of all available roles: Meteor.roles