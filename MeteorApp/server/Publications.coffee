allRoles = ['User', 'Mechanic', 'Employee', 'Redistribution', 'Admin', 'Root' ]

# General Map Data Publications:

# Meteor.publish 'RackNamesGet', (Optional) ->
#   RackNames.find({Optional: Optional})
# Meteor.publish 'RackPanel', (opt) ->
#   RackNames.find()

# Meteor.publish 'OuterLimitGet', (opt) ->
#   OuterLimit.find()

# All bikes that a common user may see:
Meteor.publish 'AvailableBikeLocationsPub', (opt) ->
  if Roles.userIsInRole(@userId, allRoles)
    [today, now] = CurrentDay()
    DailyBikeData.find {Tag: 'Available', Day: today}, fields: Positions: 0
  else
    @stop()
Meteor.publish 'ReservedBike', (opt) ->
  # Possibly redundant, but nonetheless good:
  if Roles.userIsInRole(@userId, allRoles)
    [today, now] = CurrentDay()
    DailyBikeData.find {Tag: @userId, Day: today}, fields: Positions: 0
  else
    @stop()

# Administrative Publications

# Give authorized users access to sensitive data by group
Meteor.publish 'DailyBikeDataPub', (opt) ->
  if Roles.userIsInRole(@userId, ['Root', 'Admin', 'Employee'])
    DailyBikeData.find()
  else
    @stop()

Meteor.publish 'ManageUsers', (opt) ->
  if Roles.userIsInRole(@userId, ['Root', 'Admin'])
    Meteor.users.find()
  else
    @stop()


# Root - complete list of publications only available to one user:
Meteor.publish 'Pub_Users', (opt) ->
  if Roles.userIsInRole(@userId, ['Root'])
    Meteor.users.find()
  else
    @stop()
Meteor.publish 'Pub_DailyBikeData', (opt) ->
  if Roles.userIsInRole(@userId, ['Root'])
    DailyBikeData.find()
  else
    @stop()
Meteor.publish 'Pub_RackNames', (opt) ->
  if Roles.userIsInRole(@userId, ['Root'])
    RackNames.find()
  else
    @stop()
Meteor.publish 'Pub_OuterLimit', (opt) ->
  if Roles.userIsInRole(@userId, ['Root'])
    OuterLimit.find()
  else
    @stop()
Meteor.publish 'Pub_RFIDtags', (opt) ->
  if Roles.userIsInRole(@userId, ['Root'])
    RFIDtags.find()
  else
    @stop()
Meteor.publish 'Pub_MechanicNotes', (opt) ->
  if Roles.userIsInRole(@userId, ['Root'])
    MechanicNotes.find()
  else
    @stop()
Meteor.publish 'Pub_XbeeData', (opt) ->
  if Roles.userIsInRole(@userId, ['Root'])
    XbeeData.find()
  else
    @stop()

# Meteor.publish "ManageBikes", (opt) ->
#   DailyBikeData.find({Tag: {$ne: "Removed"}}, {fields: {Positions: 0}})

# Meteor.publish "ManageMechanicNotes", (opt) ->
#   MechanicNotes.find({Tag: {$ne: "Removed"}}, {fields: {Positions: 0}})

# # Give authorized users access to sensitive data by group
# Meteor.publish 'RedistributionCollectionPub', (opt) ->
#   if Roles.userIsInRole(@userId, ['Redistribution', 'Admin', 'Root'])
#     RedistributionCollection.find()
#   else
#     # user not authorized. do not publish RedistributionCollection
#     @stop()



# # ###***************###

# # ###  Admin View         ###

# # ###***************###

# # # Mechanic Filler Data
# # Meteor.publish 'RandNamesData', (opt) ->
# #   RandNames.find()
# # Meteor.publish 'RandMechanicNamesData', (opt) ->
# #   RandMechanicNames.find()
# # # Bike data used in mechanic layout
# # Meteor.publish 'bikesData', (opt) ->
# #   Bikes.find()

# # RFID Confirmation and Storage Test Data
# Meteor.publish 'RFIDdataPublication', (opt) ->
#   RFIDdata.find()
# Meteor.publish 'XbeeDataPublication', (opt) ->
#   XbeeData.find()


# # ###**********************###

# # ###  Sample Chart Data          ###

# # ###**********************###

# # Used in user profile
# Meteor.publish 'BarChartData', (opt) ->
#   BarChart.find()
# # Used on admin page:
# Meteor.publish 'AdminBarChartData', (opt) ->
#   AdminBarChart.find()
# Meteor.publish 'AdminAreaChartData', (opt) ->
#   AdminAreaChart.find()

# # ###**********************###

# # ###  Named Admin Views          ###

# # ###**********************###

# # # Admin 2 and Admin 3
# # Meteor.publish 'TestUsersData', (opt) ->
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
# # Meteor.publish 'TimeSeriesData', (opt) ->
# #   TimeSeries.find()
# # # chartsAdmin.js
# # Meteor.publish 'informationTestData', (opt) ->
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
# # Meteor.publish 'SortTime', (opt) ->
# #   SortTime.find()
