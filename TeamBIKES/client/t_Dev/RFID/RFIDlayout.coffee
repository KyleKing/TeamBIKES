Meteor.subscribe 'RFIDdataPublication'
Meteor.subscribe 'XbeeDataPublication'

Template.RFIDlayout.helpers
  RFIDlayout: ->
    RFIDdata.find()
  XbeeLayout: ->
    # Reference table for development
    XbeeData.find().fetch()


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
  # in: 'highlight-row'
  # out: 'highlight-row'
  in: 'animated fast fadeInUp'
  out: 'animated fast rollOut'
  # inCallback: ->
  #   title = $(this).find('.title').text()
  #   Logs.insert text: 'Inserted ' + title + ' to the DOM'
  #   return
  # outCallback: ->
  #   title = $(this).find('.title').text()
  #   Logs.insert text: 'Removed ' + title + ' from the DOM'

# Template.RFIDlayout.uihooks '.item':
#   container: '.container'
#   insert: (node, next, tpl) ->
#     console.log 'Inserting an item.'
#     $(node).insertBefore next
#     return
#   move: (node, next, tpl) ->
#     console.log 'Moving an item.'
#     return
#   remove: (node, tpl) ->
#     console.log 'Removing an item.'
#     $(node).remove()
#     return

# # Need to make reactive
# Template.RFIDlayout.uihooks '.RFIDrow':
#   container: '.wrapper'
#   insert: (node, next, tpl) ->
#     # $(node).removeClass 'highlight-row'
#     # $(node).insertBefore next
#     console.log $(node)
#     console.log next
#     console.log tpl
#     console.log 'Inserting an item.'
#   move: (node, next, tpl) ->
#     console.log 'Moving an item.'
#   remove: (node, tpl) ->
#     console.log 'Removing an item.'
#     $(node).remove()
