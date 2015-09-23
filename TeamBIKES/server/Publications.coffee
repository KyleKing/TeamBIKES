Meteor.publish 'RackNamesGet', (Optional) ->
  RackNames.find({Optional: Optional})

Meteor.publish 'OuterLimitGet', ->
  OuterLimit.find()


# Server/Publications.coffee

# Give authorized users access to sensitive data by group
# Meteor.publish 'DailyBikeDataPub', (group) ->
Meteor.publish 'DailyBikeDataPub', ->
  # if Roles.userIsInRole(@userId, ['Admin', 'Root', 'Mechanic'], group)
  #   DailyBikeData.find()
  # else
  #   # user not authorized. do not publish MechanicNotes
  #   @stop()
  #   return
  DailyBikeData.find()

Meteor.publish 'AvailableBikeLocationsPub', ->
  [today, now] = CurrentDay()
  DailyBikeData.find {Tag: 'Available', Day: today}, fields: Positions: 0
Meteor.publish 'ReservedBike', ->
  [today, now] = CurrentDay()
  DailyBikeData.find {Tag: @userId, Day: today}, fields: Positions: 0

Meteor.publish "ManageBikes", ->
  DailyBikeData.find({Tag: {$ne: "Removed"}}, {fields: {Positions: 0}})

Meteor.publish 'ManageUsers', ->
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

# Used in user profile
Meteor.publish 'BarChartData', ->
  BarChart.find()
# Used on admin page:
Meteor.publish 'AdminBarChartData', ->
  AdminBarChart.find()
Meteor.publish 'AdminAreaChartData', ->
  AdminAreaChart.find()

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



# # server/publish.js
# # Give authorized users access to sensitive data by group
# Meteor.publish 'secrets', (group) ->
#   if Roles.userIsInRole(@userId, [ 'admin' ], group)
#     Meteor.secrets.find group: group
#   else
#     # user not authorized. do not publish secrets
#     @stop()

# Accounts.validateNewUser (user) ->
#   loggedInUser = Meteor.user()
#   if Roles.userIsInRole(loggedInUser, [
#       'admin'
#       'manage-users'
#     ])
#     return true
#   throw new (Meteor.Error)(403, 'Not authorized to create new users')

# # server/userMethods.js
# Meteor.methods updateRoles: (targetUserId, roles, group) ->
#   loggedInUser = Meteor.user()
#   if !loggedInUser or !Roles.userIsInRole(loggedInUser, [
#       'manage-users'
#       'support-staff'
#     ], group)
#     throw new (Meteor.Error)(403, 'Access denied')
#   Roles.setUserRoles targetUserId, roles, group