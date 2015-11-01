Meteor.subscribe 'RFIDdataPublication'
Template.RFIDlayout.helpers RFIDlayout: ->
  # $( '.1445951109624').addClass( "highlight" )
  # $( ".highlight" ).removeClass( "highlight" )
  RFIDdata.find().fetch()

# [today, now] = CurrentDay()
# $( ".highlight" ).removeClass( "highlight" );
# y = document.getElementsByClassName('highlight')
# # y[y.length].css('background-color: red')
# y[0].css('background-color: green')

Template.RFIDlayout.events
  'click #DeleteRFID': ->
    console.log @_id + ' will be deleted'
    # Only able to delete by id
    RFIDdata.remove @_id
  'click #DeleteOldRFID': ->
    console.log 'Deleting all RFID data'
    # Not allowed to call mongo remove query from client, so call method
    Meteor.call 'DeleteOldRFID'