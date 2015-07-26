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
  Location:
    type: Object
  'Location.type':
    type: String
  'Location.coordinates':
    type: [Number]
    decimal: true
  Positions:
    type: [ Object ]
  'Positions.$.Rider':
    type: String
    optional: true
  'Positions.$.Timestamp':
    type: Date
  'Positions.$.Location':
    type: Object
  'Positions.$.Location.type':
    type: String
  'Positions.$.Location.coordinates':
    type: [Number]
    decimal: true)

# Specific bike information: repairs, serial number, etc.
@MechanicNotes = new Mongo.Collection 'mechanicNotes'
MechanicNotes.attachSchema new SimpleSchema(
  MechanicID:
    type: String
    label: 'ID'
  Timestamp:
    type: String
    label: 'Timestamp'
  Bike:
    type: Number
    label: 'Bike Number'
    min: 0
  Notes:
    type: String
    label: 'Notes'
  Tag:
    type: String
    label: 'Tag')



## WIP
# TBD: Bikes to be redistributed?
@RedistributionCollection = new Mongo.Collection 'redistributionCollection'

@RFIDdata = new Mongo.Collection 'RFIDdata'

# For testing Webix
@Movies = new Mongo.Collection 'movies'
@Books = new Mongo.Collection 'books'


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