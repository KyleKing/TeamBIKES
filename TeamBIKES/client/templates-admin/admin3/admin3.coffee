Meteor.subscribe 'TestUsersData'
Meteor.call 'eachBike'
Meteor.subscribe 'TestUsersDataSorted'

Template.admin3layout.created = ->
  # Default to all users view
  Session.set 'ViewUsers', 0
  return

# Use UI.registerHelper..
# Copied fromL http://stackoverflow.com/questions/18580495/format-a-date-from-inside-a-handlebars-template-in-meteor
UI.registerHelper 'formatDate', (datetime, format) ->
  DateFormats =
    shortest: 'MMM D, YYYY'
    short: 'hh:mm:ss a - MMM D, YYYY'
    long: 'H:m:s a - MMM D, YYYY'
  if moment
    # can use other formats like 'lll' too
    format = DateFormats[format] or format
    moment(datetime).format format
  else
    datetime
Template.admin3layout.helpers
  admin3layout: ->
    # Used for testing and direct access to second page
    # Session.set('ViewUsers', TimeSeries.findOne({bike: 1})._id);
    # Return all bikes in system
    if Session.get('ViewUsers') == 0
      # var data = TimeSeries.find({day: 71}).fetch();
      data = TimeSeries.find().fetch()
      _.sortBy data, 'bike'
    else
      # Return only the clicked bike:
      bikeData = TimeSeries.findOne(_id: Session.get('ViewUsers')).positions
      _.sortBy(bikeData, 'timestamp').reverse()
  ViewUsersFunc: ->
    if Session.get('ViewUsers') == 0
      # console.log('True: ' + Session.get('ViewUsers'));
      false
    else
      # console.log('False: ' + Session.get('ViewUsers'));
      true
# open the particular users history
Template.admin3layout.events 'click .seeMore': ->
  Session.set 'ViewUsers', @_id
  return
# Return to the main layout view
Template.admin3layout.events 'click .seeLess': ->
  Session.set 'ViewUsers', 0
  return

# ---
# generated by js2coffee 2.0.4