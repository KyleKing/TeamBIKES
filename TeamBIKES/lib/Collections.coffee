# All bike positional information
@DailyBikeData = new Mongo.Collection 'dailyBikeData'
DailyBikeData.attachSchema new SimpleSchema(
  Bike:
    type: Number
    label: 'Bike Number'
    min: 0
  Day:
    type: Number
    label: 'Day'
    min: 0
    max: 367
  Tag:
    type: String
    label: 'Tag'
  Coordinates:
    type: [Number]
    decimal: true
  Positions:
    type: [ Object ]
  'Positions.$.Rider':
    type: String
    optional: true
  'Positions.$.Timestamp':
    type: Number
    decimal: true
  'Positions.$.Coordinates':
    type: [Number]
    decimal: true)

# Specific bike information: repairs, serial number, etc.
@MechanicNotes = new Mongo.Collection 'mechanicNotes'
MechanicNotes.attachSchema new SimpleSchema(
  MechanicID:
    type: String
    label: 'MechanicID'
  Timestamp:
    type: Number
    decimal: true
  Bike:
    type: Number
    min: 0
  Notes:
    type: String
  Tag:
    type: String)



## WIP
# TBD: Bikes to be redistributed?
@RedistributionCollection = new Mongo.Collection 'redistributionCollection'
@RandMechanicNames = new Mongo.Collection 'randMechanicNames'
# @RFIDdata = new Mongo.Collection 'RFIDdata'

# Used in user profile
@BarChart = new (Meteor.Collection)('barchart')
@AdminBarChart = new (Meteor.Collection)('adminbarchart')
@AdminAreaChart = new (Meteor.Collection)('adminareachart')


# # All the options from the core documentation at:
# # https://github.com/aldeed/meteor-collection2#attach-a-schema-to-meteorusers
# Schema = {}
# Schema.UserProfile = new SimpleSchema(
#   firstName:
#     type: String
#     regEx: /^[a-zA-Z-]{2,25}$/
#     optional: true
#   lastName:
#     type: String
#     regEx: /^[a-zA-Z]{2,25}$/
#     optional: true)
# Schema.User = new SimpleSchema(
#   emails:
#     type: [ Object ]
#     optional: true
#   'emails.$.address':
#     type: String
#     regEx: SimpleSchema.RegEx.Email
#   'emails.$.verified': type: Boolean
#   createdAt: type: Date
#   profile:
#     type: Schema.UserProfile
#     optional: true
#   roles:
#     type: Object
#     optional: true
#     blackbox: true
#   roles:
#     type: [ String ]
#     optional: true)


Meteor.users.attachSchema new SimpleSchema(
  createdAt:
    type: Date
  services:
    type: Object
    optional: true
    blackbox: true
  emails:
    type: [ Object ]
    optional: true
  'emails.$.address':
    type: String
    regEx: SimpleSchema.RegEx.Email
  'emails.$.verified': type: Boolean
  'profile.name':
    type: String
  roles:
    type: [ String ]
    optional: true)

# # All the options from the core documentation at:
# # https://github.com/aldeed/meteor-collection2#attach-a-schema-to-meteorusers
# Schema = {}
# Schema.UserProfile = new SimpleSchema(
#   firstName:
#     type: String
#     regEx: /^[a-zA-Z-]{2,25}$/
#     optional: true
#   lastName:
#     type: String
#     regEx: /^[a-zA-Z]{2,25}$/
#     optional: true)
# Schema.User = new SimpleSchema(
#   emails:
#     type: [ Object ]
#     optional: true
#   'emails.$.address':
#     type: String
#     regEx: SimpleSchema.RegEx.Email
#   'emails.$.verified': type: Boolean
#   createdAt: type: Date
#   profile:
#     type: Schema.UserProfile
#     optional: true
#   roles:
#     type: Object
#     optional: true
#     blackbox: true
#   roles:
#     type: [ String ]
#     optional: true)
# Meteor.users.attachSchema Schema.User