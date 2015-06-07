# server/publications/RedistributionCollection.coffee

# Give authorized users access to sensitive data by group
Meteor.publish 'RedistributionCollectionPub', (group) ->
  if Roles.userIsInRole(@userId, ['Redistribution', 'Admin', 'Root'], group)
    RedistributionCollection.find()
  else
    # user not authorized. do not publish RedistributionCollection
    @stop()
    return