allRoles = ['User', 'Mechanic', 'Employee', 'Redistribution', 'Admin', 'Root' ]

# General Map Data Publications:

# Meteor.publish 'RackNamesGet', (Optional) ->
#   RackNames.find({Optional: Optional})
# Meteor.publish 'RackPanel', (group) ->
#   RackNames.find()

# Meteor.publish 'OuterLimitGet', (group) ->
#   OuterLimit.find()

# All bikes that a common user may see:
Meteor.publish 'AvailableBikeLocationsPub', (group) ->
	if Roles.userIsInRole(@userId, allRoles, group)
  	[today, now] = CurrentDay()
  	DailyBikeData.find {Tag: 'Available', Day: today}, fields: Positions: 0
  else
    @stop()
Meteor.publish 'ReservedBike', (group) ->
	# Possibly redundant, but nonetheless good:
	if Roles.userIsInRole(@userId, allRoles, group)
	  [today, now] = CurrentDay()
	  DailyBikeData.find {Tag: @userId, Day: today}, fields: Positions: 0
  else
    @stop()

# Administrative Publications

# Give authorized users access to sensitive data by group
Meteor.publish 'DailyBikeDataPub', (group) ->
  if Roles.userIsInRole(@userId, ['Root', 'Admin', 'Employee'], group)
    DailyBikeData.find()
  else
    @stop()

Meteor.publish 'ManageUsers', (group) ->
  if Roles.userIsInRole(@userId, ['Root', 'Admin'], group)
  	Meteor.users.find()
  else
    @stop()


# Meteor.publish 'DevPanel', (group) ->
#   [today, now] = CurrentDay()
#   DailyBikeData.find {Day: today}, fields: Positions: 0

# Meteor.publish "ManageBikes", (group) ->
#   DailyBikeData.find({Tag: {$ne: "Removed"}}, {fields: {Positions: 0}})

# Meteor.publish 'ManageUsers', (group) ->
#   Meteor.users.find()

# # server/publications/MechanicNotes.coffee

# Meteor.publish "ManageMechanicNotes", (group) ->
#   MechanicNotes.find({Tag: {$ne: "Removed"}}, {fields: {Positions: 0}})



# # server/publications/MeteorUsers.coffee

# # Give authorized users access to sensitive data by group
# # Includes PII like login names, emails and roles
# Meteor.publish 'UsersPub', (group) ->
#   if Roles.userIsInRole(@userId, ['Admin', 'Mechanic', 'Root'], group)
#     Meteor.users.find()
#   else
#     # user not authorized. do not publish secrets
#     @stop()
#     return

# # Note list of all available roles: Meteor.roles




# # server/publications/RedistributionCollection.coffee

# # Give authorized users access to sensitive data by group
# Meteor.publish 'RedistributionCollectionPub', (group) ->
#   if Roles.userIsInRole(@userId, ['Redistribution', 'Admin', 'Root'], group)
#     RedistributionCollection.find()
#   else
#     # user not authorized. do not publish RedistributionCollection
#     @stop()



# # ###***************###

# # ###  Admin View         ###

# # ###***************###

# # # Mechanic Filler Data
# # Meteor.publish 'RandNamesData', (group) ->
# #   RandNames.find()
# # Meteor.publish 'RandMechanicNamesData', (group) ->
# #   RandMechanicNames.find()
# # # Bike data used in mechanic layout
# # Meteor.publish 'bikesData', (group) ->
# #   Bikes.find()

# # RFID Confirmation and Storage Test Data
# Meteor.publish 'RFIDdataPublication', (group) ->
#   RFIDdata.find()
# Meteor.publish 'XbeeDataPublication', (group) ->
#   XbeeData.find()


# # ###**********************###

# # ###  Sample Chart Data          ###

# # ###**********************###

# # Used in user profile
# Meteor.publish 'BarChartData', (group) ->
#   BarChart.find()
# # Used on admin page:
# Meteor.publish 'AdminBarChartData', (group) ->
#   AdminBarChart.find()
# Meteor.publish 'AdminAreaChartData', (group) ->
#   AdminAreaChart.find()

# # ###**********************###

# # ###  Named Admin Views          ###

# # ###**********************###

# # # Admin 2 and Admin 3
# # Meteor.publish 'TestUsersData', (group) ->
# #   TestUsers.find()
# # # Admin 3
# # # Meteor.publish("TestUserDataSorted", function() {
# # #   var TestResult = TimeSeries.aggregate([
# # #     { $match: {bike: 4} },
# # #     { $unwind: '$positions' },
# # #     { $sort: {'positions.timestamp': -1} },
# # #     { $group: {_id : "$bike", positions: {$push: '$positions'}} }
# # #   ]);
# # #   // console.log(TestResult[0].positions);
# # #   // _(TestResult[0].positions).each(function(eachSelf){
# # #   //   console.log('_each: ' + eachSelf.timestamp);
# # #   // });
# # #   // information needs to be the lowercase version from the collection, not the Meteor version
# # #   this.added('testUsers', Random.id(), {sort: true, data: TestResult[0]._id });
# # # });
# # # Sample code for above
# # # Meteor.publish('previousInviteContacts', function() {
# # #   contacts = Events.aggregate([
# # #       {$match: {creatorId: this.userId}},
# # #       {$project: {invites: 1}},
# # #       {$unwind: "$invites" },
# # #       {$group: {_id: {email: "$invites.email"}}},
# # #       {$project: {email: "$_id.email"}}
# # #     ]);
# # #   _(contacts).each(function(contact) {
# # #     if (contact.email) {
# # #       if (!Contacts.findOne({userId: this.userId, email: contact.email})) {
# # #         this.added('contacts', Random.id(), {email: contact.email, userId: this.userId, name: ''});
# # #       }
# # #     }
# # #   });
# # # });
# # # Subscription call inside charts-admin/chartsAdmin.js
# # Meteor.publish 'TimeSeriesData', (group) ->
# #   TimeSeries.find()
# # # chartsAdmin.js
# # Meteor.publish 'informationTestData', (group) ->
# #   pipeline = [
# #     { $match: bike: 4 }
# #     { $unwind: '$positions' }
# #     { $sort: 'positions.timestamp': -1 }
# #     { $group:
# #       _id: '$bike'
# #       positions: $push: '$positions' }
# #   ]
# #   TestResult = TimeSeries.aggregate(pipeline)
# #   # console.log(TestResult[0].positions);
# #   # _(TestResult[0].positions).each(function(eachSelf){
# #   #   console.log('_each: ' + eachSelf.timestamp);
# #   # });
# #   # information needs to be the lowercase version from the collection, not the Meteor version
# #   @added 'information', Random.id(),
# #     email: 'Kyle@email.com'
# #     userId: @userId
# #     data: TestResult[0]._id
# #   return
# # Meteor.publish 'SortTime', (group) ->
# #   SortTime.find()

# # ###***************###

# # ###  User View          ###

# # ###***************###

# # # Login Demo - Famous Dead People Package
# # Meteor.publish 'users', (group) ->
# #   Meteor.users.find()
# # # Map data
# # Meteor.publish 'currentData', (group) ->
# #   Current.find()



# # # server/publish.js
# # # Give authorized users access to sensitive data by group
# # Meteor.publish 'secrets', (group) ->
# #   if Roles.userIsInRole(@userId, [ 'admin' ], group)
# #     Meteor.secrets.find group: group
# #   else
# #     # user not authorized. do not publish secrets
# #     @stop()

# # Accounts.validateNewUser (user) ->
# #   loggedInUser = Meteor.user()
# #   if Roles.userIsInRole(loggedInUser, [
# #       'admin'
# #       'manage-users'
# #     ])
# #     return true
# #   throw new (Meteor.Error)(403, 'Not authorized to create new users')

# # # server/userMethods.js
# # Meteor.methods updateRoles: (targetUserId, roles, group) ->
# #   loggedInUser = Meteor.user()
# #   if !loggedInUser or !Roles.userIsInRole(loggedInUser, [
# #       'manage-users'
# #       'support-staff'
# #     ], group)
# #     throw new (Meteor.Error)(403, 'Access denied')
# #   Roles.setUserRoles targetUserId, roles, group