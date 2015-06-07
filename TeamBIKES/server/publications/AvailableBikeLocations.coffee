# server/publications/DailyBikeData.coffee

# Give authorized users access to sensitive data by group
# Published as null so no subscription call unnecessary, for now
Meteor.publish ->
  AvailableBikeLocations.find()