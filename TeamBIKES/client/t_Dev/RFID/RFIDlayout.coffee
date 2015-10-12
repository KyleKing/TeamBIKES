Meteor.subscribe 'RFIDdataPublication'
Template.RFIDlayout.helpers RFIDlayout: ->
  RFIDdata.find().fetch()