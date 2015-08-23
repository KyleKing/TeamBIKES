# Server/Publications.coffee

# Give authorized users access to sensitive data by group
Meteor.publish 'DailyBikeDataPub', (group) ->
  if Roles.userIsInRole(@userId, ['Admin', 'Root', 'Mechanic'], group)
    DailyBikeData.find()
  else
    # user not authorized. do not publish MechanicNotes
    @stop()

Meteor.publish 'AvailableBikeLocationsPub', ->
  DailyBikeData.find {Tag: 'Available'}, fields: Positions: 0
Meteor.publish 'ReservedBike', ->
  DailyBikeData.find {Tag: @userId}, fields: Positions: 0
Meteor.publish "ManageBikes", ->
  DailyBikeData.find({Tag: {$ne: "Removed"}}, {fields: {Positions: 0}})


Meteor.publish 'ManageUsers', () ->
  Meteor.users.find()



# server/publications/MechanicNotes.coffee

# Give authorized users access to sensitive data by group
Meteor.publish 'MechanicNotesPub', (group) ->
  if Roles.userIsInRole(@userId, ['Admin', 'Root', 'Mechanic'], group)
    MechanicNotes.find()
  else
    # user not authorized. do not publish MechanicNotes
    @stop()
    return

Meteor.publish "ManageMechanicNotes", ->
  MechanicNotes.find({Tag: {$ne: "Removed"}}, {fields: {Positions: 0}})



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




# server/publications/RedistributionCollection.coffee

# Give authorized users access to sensitive data by group
Meteor.publish 'RedistributionCollectionPub', (group) ->
  if Roles.userIsInRole(@userId, ['Redistribution', 'Admin', 'Root'], group)
    RedistributionCollection.find()
  else
    # user not authorized. do not publish RedistributionCollection
    @stop()



# ###***************###

# ###  Admin View         ###

# ###***************###

# # Mechanic Filler Data
# Meteor.publish 'RandNamesData', ->
#   RandNames.find()
# Meteor.publish 'RandMechanicNamesData', ->
#   RandMechanicNames.find()
# # Bike data used in mechanic layout
# Meteor.publish 'bikesData', ->
#   Bikes.find()
# # RFID Confirmation and Storage Test Data
# Meteor.publish 'RFIDdataPublication', ->
#   RFIDdata.find()

# ###**********************###

# ###  Sample Chart Data          ###

# ###**********************###

# # Used in user profile
# Meteor.publish 'BarChartData', ->
#   BarChart.find()
# # Used on admin page:
# Meteor.publish 'AdminBarChartData', ->
#   AdminBarChart.find()
# Meteor.publish 'AdminAreaChartData', ->
#   AdminAreaChart.find()

# ###**********************###

# ###  Named Admin Views          ###

# ###**********************###

# # Admin 2 and Admin 3
# Meteor.publish 'TestUsersData', ->
#   TestUsers.find()
# # Admin 3
# # Meteor.publish("TestUserDataSorted", function() {
# #   var TestResult = TimeSeries.aggregate([
# #     { $match: {bike: 4} },
# #     { $unwind: '$positions' },
# #     { $sort: {'positions.timestamp': -1} },
# #     { $group: {_id : "$bike", positions: {$push: '$positions'}} }
# #   ]);
# #   // console.log(TestResult[0].positions);
# #   // _(TestResult[0].positions).each(function(eachSelf){
# #   //   console.log('_each: ' + eachSelf.timestamp);
# #   // });
# #   // information needs to be the lowercase version from the collection, not the Meteor version
# #   this.added('testUsers', Random.id(), {sort: true, data: TestResult[0]._id });
# # });
# # Sample code for above
# # Meteor.publish('previousInviteContacts', function() {
# #   contacts = Events.aggregate([
# #       {$match: {creatorId: this.userId}},
# #       {$project: {invites: 1}},
# #       {$unwind: "$invites" },
# #       {$group: {_id: {email: "$invites.email"}}},
# #       {$project: {email: "$_id.email"}}
# #     ]);
# #   _(contacts).each(function(contact) {
# #     if (contact.email) {
# #       if (!Contacts.findOne({userId: this.userId, email: contact.email})) {
# #         this.added('contacts', Random.id(), {email: contact.email, userId: this.userId, name: ''});
# #       }
# #     }
# #   });
# # });
# # Subscription call inside charts-admin/chartsAdmin.js
# Meteor.publish 'TimeSeriesData', ->
#   TimeSeries.find()
# # chartsAdmin.js
# Meteor.publish 'informationTestData', ->
#   pipeline = [
#     { $match: bike: 4 }
#     { $unwind: '$positions' }
#     { $sort: 'positions.timestamp': -1 }
#     { $group:
#       _id: '$bike'
#       positions: $push: '$positions' }
#   ]
#   TestResult = TimeSeries.aggregate(pipeline)
#   # console.log(TestResult[0].positions);
#   # _(TestResult[0].positions).each(function(eachSelf){
#   #   console.log('_each: ' + eachSelf.timestamp);
#   # });
#   # information needs to be the lowercase version from the collection, not the Meteor version
#   @added 'information', Random.id(),
#     email: 'Kyle@email.com'
#     userId: @userId
#     data: TestResult[0]._id
#   return
# Meteor.publish 'SortTime', ->
#   SortTime.find()

# ###***************###

# ###  User View          ###

# ###***************###

# # Login Demo - Famous Dead People Package
# Meteor.publish 'users', ->
#   Meteor.users.find()
# # Map data
# Meteor.publish 'currentData', ->
#   Current.find()