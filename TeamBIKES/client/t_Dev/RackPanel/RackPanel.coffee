Meteor.subscribe 'RackPanel'

Template.RackPanel.helpers
  RackPanel: ->
    RackNames.find()

Template.RackPanel.events
  # 'click #DeleteBike': ->
  #   console.log @_id + ' will be deleted'
  #   # Only able to delete by id
  #   DailyBikeData.remove @_id
  'click #DeleteRacks': ->
    console.log 'Deleting all Racks'
    # Not allowed to call mongo remove query from client, so call method
    Meteor.call 'DeleteRacks'

  'click #ChangeHighlight': (event) ->
    if event.currentTarget.value
      TargetClass = '.' + event.currentTarget.value
      console.log TargetClass + ' will be ChangeHighlight-ed'
      $(TargetClass).toggleClass 'highlight-row'
    else
      console.log event
      console.log event.currentTarget
      console.log event.currentTarget.value

  # 'click #RepopulateDailyBikeData': ->
  #   console.log 'Repopulating DailyBikeData'
  #   # Not allowed to call mongo remove query from client, so call method
  #   Meteor.call 'RepopulateDailyBikeData'
  # 'click #CreateBike': ->
  #   console.log 'Creating a Bike'
  #   # Not allowed to call mongo remove query from client, so call method
  #   Meteor.call 'CreateBike'

Template.RackPanel.animations '.item':
  animateInitial: true
  animateInitialStep: 200
  animateInitialDelay: 0
  container: '.wrapper'
  in: 'animated fast fadeInUp'
  out: 'animated fast fadeOutRight'