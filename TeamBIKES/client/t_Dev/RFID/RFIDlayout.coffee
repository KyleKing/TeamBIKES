Meteor.subscribe 'RFIDdataPublication'
Meteor.subscribe 'XbeeDataPublication'

Template.RFIDlayout.helpers
  RFIDlayout: ->
    RFIDdata.find()
  XbeeLayout: ->
    # Reference table for development
    XbeeData.find().fetch()

Template.RFIDlayout.events
  'click #DeleteRFID': ->
    console.log @_id + ' will be deleted'
    # Only able to delete by id
    RFIDdata.remove @_id
  'click #DeleteOldRFID': ->
    console.log 'Deleting all RFID data'
    # Not allowed to call mongo remove query from client, so call method
    Meteor.call 'DeleteOldRFID'

  'click #ChangeHighlight': (event) ->
    TargetClass = '.' + event.currentTarget.value
    console.log TargetClass + ' will be ChangeHighlight-ed'
    $(TargetClass).removeClass 'highlight-row'
  'click #CreateRFID': ->
    console.log 'Creating a RFID data'
    # Not allowed to call mongo remove query from client, so call method
    Meteor.call 'CreateRFID'

# Template.RFIDlayout.animations '.item':
#   container: '.wrapper'
#   insert:
#     class: 'highlight-row'
#     before: (attrs, element, template) ->
#     after: (attrs, element, template) ->
#     delay: 50
#   remove:
#     class: 'highlight-row'
#     before: (attrs, element, template) ->
#     after: (attrs, element, template) ->
#     delay: 50
#   animateInitial: true
#   animateInitialStep: 200
#   animateInitialDelay: 50

Template.RFIDlayout.animations '.item':
  animateInitial: true
  animateInitialStep: 200
  animateInitialDelay: 0
  container: '.wrapper'
  in: 'animated fast fadeInUp'
  # move: 'animated fast fadeOut'
  # https://github.com/gwendall/meteor-blaze-animations/blob/master/lib.js#L142
  # Cool thing to build!
  out: 'animated fast fadeOutRight'
  # Create logs database..
  # inCallback: ->
  #   title = $(this).find('.title').text()
  #   Logs.insert text: 'Inserted ' + title + ' to the DOM'
  #   return
  # outCallback: ->
  #   title = $(this).find('.title').text()
  #   Logs.insert text: 'Removed ' + title + ' from the DOM'
