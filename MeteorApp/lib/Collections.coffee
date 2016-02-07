@DailyBikeData = new Mongo.Collection('dailyBikeData')

# Nested Class
nestedPositions = Astro.Class(
  name: 'nestedPositions'
  fields:
    Tag: 'string'
    Rider: 'string'
    Timestamp: 'number'
    Coordinates: 'array'
)
@DailyBikeDatum = Astro.Class(
  name: 'DailyBikeDatum'
  collection: DailyBikeData
  fields:
    Bike:
      type: 'number'
      validator: Validators.and [
        Validators.number()
        Validators.gt(0)
        Validators.lte(100)
      ]
    Day:
      type: 'number'
      validator: Validators.and [
        Validators.number()
        Validators.gt(0)
        Validators.lte(365)
      ]
    Tag:
      type: 'string'
      validator:  Validators.and [
        Validators.string()
        Validators.choice([
          'ToBeRedistributed', 'RepairToBeStarted'
          'RepairInProgress', 'WaitingOnParts', 'Available'
        ])
      ]
    Coordinates:
      type: 'array'
      nested: 'number'
      default: ->
        []
    Positions:
      type: 'array'
      nested: 'nestedPositions'
      default: ->
        []
)

# @RackNames = new Mongo.Collection 'racknames'
# @OuterLimit = new Mongo.Collection 'outerlimit'

# # Specific bike information: repairs, serial number, etc.
# @MechanicNotes = new Mongo.Collection 'mechanicNotes'
# MechanicNotes.attachSchema new SimpleSchema(
#   MechanicID:
#     type: String
#     label: 'MechanicID'
#   Timestamp:
#     type: Number
#     decimal: true
#   Bike:
#     type: Number
#     min: 0
#   Notes:
#     type: String
#   Tag:
#     type: String)


# ## WIP
# # TBD: Bikes to be redistributed?
# @RedistributionCollection = new Mongo.Collection 'redistributionCollection'
# @RandMechanicNames = new Mongo.Collection 'randMechanicNames'
# @RFIDdata = new Mongo.Collection 'RFIDdata'
# @XbeeData = new Mongo.Collection 'XbeeData'

# # Used in user profile
# @BarChart = new (Meteor.Collection)('barchart')
# @AdminBarChart = new (Meteor.Collection)('adminbarchart')
# @AdminAreaChart = new (Meteor.Collection)('adminareachart')


# # # All the options from the core documentation at:
# # # https://github.com/aldeed/meteor-collection2#attach-a-schema-to-meteorusers
# # Schema = {}
# # Schema.UserProfile = new SimpleSchema(
# #   firstName:
# #     type: String
# #     regEx: /^[a-zA-Z-]{2,25}$/
# #     optional: true
# #   lastName:
# #     type: String
# #     regEx: /^[a-zA-Z]{2,25}$/
# #     optional: true)
# # Schema.User = new SimpleSchema(
# #   emails:
# #     type: [ Object ]
# #     optional: true
# #   'emails.$.address':
# #     type: String
# #     regEx: SimpleSchema.RegEx.Email
# #   'emails.$.verified': type: Boolean
# #   createdAt: type: Date
# #   profile:
# #     type: Schema.UserProfile
# #     optional: true
# #   roles:
# #     type: Object
# #     optional: true
# #     blackbox: true
# #   roles:
# #     type: [ String ]
# #     optional: true)


# Meteor.users.attachSchema new SimpleSchema(
#   createdAt:
#     type: Date
#   services:
#     type: Object
#     optional: true
#     blackbox: true
#   emails:
#     type: [ Object ]
#     optional: true
#   'emails.$.address':
#     type: String
#     regEx: SimpleSchema.RegEx.Email
#   'emails.$.verified': type: Boolean
#   'profile.name': type: String
#   'profile.RFID': type: String
#   # # Always use Roles.addUsersToRoles(userId, ["admin"], Roles.GLOBAL_GROUP);
#   # roles:
#   #   type: Object
#   #   optional: true
#   #   blackbox: true)
#   roles:
#     type: [ String ]
#     optional: true)


# # # All the options from the core documentation at:
# # # https://github.com/aldeed/meteor-collection2#attach-a-schema-to-meteorusers
# # Schema = {}
# # Schema.UserProfile = new SimpleSchema(
# #   firstName:
# #     type: String
# #     regEx: /^[a-zA-Z-]{2,25}$/
# #     optional: true
# #   lastName:
# #     type: String
# #     regEx: /^[a-zA-Z]{2,25}$/
# #     optional: true)
# # Schema.User = new SimpleSchema(
# #   emails:
# #     type: [ Object ]
# #     optional: true
# #   'emails.$.address':
# #     type: String
# #     regEx: SimpleSchema.RegEx.Email
# #   'emails.$.verified': type: Boolean
# #   createdAt: type: Date
# #   profile:
# #     type: Schema.UserProfile
# #     optional: true
# #   roles:
# #     type: Object
# #     optional: true
# #     blackbox: true
# #   roles:
# #     type: [ String ]
# #     optional: true)
# # Meteor.users.attachSchema Schema.User


# Cron scheduling
@FutureTasks = new Meteor.Collection('future_tasks')
