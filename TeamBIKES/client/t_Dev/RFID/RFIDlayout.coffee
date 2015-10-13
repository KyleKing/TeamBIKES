Meteor.subscribe 'RFIDdataPublication'
Template.RFIDlayout.helpers RFIDlayout: ->
  RFIDdata.find().fetch()

Template.RFIDlayout.events
  'click #DeleteRFID': ->
    console.log @_id + ' will be deleted'
    # Only able to delete by id
    RFIDdata.remove @_id
  'click #DeleteOldRFID': ->
    console.log 'Deleting all RFID data'
    # Not allowed to call mongo remove query from client, so call method
    Meteor.call 'DeleteOldRFID'