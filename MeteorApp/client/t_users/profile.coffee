# Profile Logic
################################################
Template.profile.events
  'click #deactivateRFID': ->
    console.log 'Deactivating user RFID Code'
    oldRFID = Meteor.user().profile.RFID
    re = /^deactivated/i
    if oldRFID.match(re)
      # Already deactivated
      newRFID = oldRFID
    else
      newRFID = 'deactivated-' + oldRFID
    Meteor.users.update(
      {_id: Meteor.userId()},
      {$set: { 'profile.RFID': newRFID }}
    )
    # Should be reactive, but isn't
    FlowRouter.go('/profile')

Template.profile.helpers
  'userName': ->
    if Meteor.user()
      return ' ' + Meteor.user().profile.name
    else
      return ''
  'registeredRFID': ->
    if Meteor.user()
      RFIDCode = Meteor.user().profile.RFID
      if RFIDCode is 'signUp'
        return false
      else
        return true
    else
      return false

# RFID Form Logic
################################################
Forms.mixin(Template.profile)

Template.profile.onRendered ->
  @autorun( ->
    form = Forms.instance()
    if Meteor.user()
      RFIDCode = Meteor.user().profile.RFID
      if RFIDCode is 'signUp'
        RFIDCode = ''
      re = /^deactivated/i
      if RFIDCode.match(re)
        console.log RFIDCode
        RFIDCode = ''
      form.doc({
        fullName: Meteor.user().profile.name
        RFIDCode: RFIDCode
      })
  )

Template.profile.events
  'documentSubmit': (event, tmpl, doc) ->
    console.log doc
    console.log 'Updating user RFID Code'
    Meteor.users.update(
      {_id: Meteor.userId()},
      {$set: { 'profile.RFID': doc.RFIDCode }}
    )

# Fancy Chart
################################################

Template.profile.onRendered ->
  Session.set('x', ['x', "Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"])
  Session.set('Last Week', ['Last Week', 2, 6, 10, 2, 11, 15, 8])
  Session.set('This Week', ['This Week', 15, 8, 9, 3, 4, 0])
  chart = c3.generate({
    bindto: @find('.profile-chart')
    data: {
      xs: {
        'Last Week': 'x'
        'This Week': 'x'
      },
      columns: [
        ['x'], ['Last Week'], ['This Week']
      ]
    }
    grid: {
      y: {
        show: true
      }
    }
    axis: {
      y: {
        min: 0
        label: {
          text: 'Number of rides',
          position: 'outer-middle'
        }
      },
      x: {
        type: 'category'
      }
    }
  })

  @autorun( (tracker) ->
    chart.load({columns: [
      Session.get('x'),
      Session.get('Last Week'),
      Session.get('This Week'),
      []
    ]})
  )

# Table of Bikes
################################################
Template.profile.events 'click tbody > tr': (event) ->
  # Store the id of the row clicked by the user
  dataTable = $(event.target).closest('table').DataTable()
  rowData = dataTable.row(event.currentTarget).data()
  Session.set "IDofSelectedRowBikes", rowData._id
  # FlowRouter.go('/ManageBike/' + rowData._id)
  FlowRouter.go('/Dashboard/ManageBike/' + rowData._id)
  $('.cd-panel').addClass 'is-visible'
  $('body').addClass 'noscroll'

  # # Provide user feedback with a highlighted
  # $('.selected').removeClass 'selected'
  # $(event.currentTarget).toggleClass 'selected'

Template.profile.helpers
  selector: ->
    [today, now] = CurrentDay()
    { Day: today }

# Reactive Var Modulation example
# Source: https://github.com/aldeed/meteor-tabular/issues/79
Template.profile.created = ->
  TCS.Created('RecentRides')

Template.profile.rendered = ->
  TCS.Rendered('RecentRides', 'RecentRides')

Template.profile.helpers
  currentSelector: ->
    TCS.Helper('RecentRides')
