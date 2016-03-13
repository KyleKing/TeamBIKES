# Profile Logic
################################################
Template.profile.events
  'click #deactivateRFID': ->
    oldRFID = Meteor.user().profile.RFID
    re = /^deactivated/i
    if RFIDCode.match(re)
      newRFID = 'deactivated-' + oldRFID
    else
      newRFID = oldRFID
    Meteor.users.update(
      {_id: Meteor.userId()},
      {$set: { 'profile.RFID': newRFID }}
    )

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
Forms.mixin(Template.RFIDForm)

Template.RFIDForm.rendered = ->
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

Template.RFIDForm.events
  'documentSubmit': (event, tmpl, doc) ->
    # console.log doc
    Meteor.users.update(
      {_id: Meteor.userId()},
      {$set: { 'profile.RFID': doc.RFIDCode }}
    )

# Fancy Chart
################################################

Template.profile.rendered = ->
  Session.set('x', ['x', "Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"])
  Session.set('Last Week', ['Last Week', 2, 6, 10, 2, 11, 15, 8])
  Session.set('This Week', ['This Week', 15, 8, 9, 3, 4, 0])
  chart = c3.generate({
    bindto: @find('.chart')
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
