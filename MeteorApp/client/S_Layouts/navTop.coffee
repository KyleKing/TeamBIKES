Template.navTop.events
  "click button#log-out-btn": (e) ->
    if Meteor.userId()
      AccountsTemplates.logout()

Template.navTop.helpers
  'RFIDeh': ->
    if Meteor.user()
      RFIDCode = Meteor.user().profile.RFID
      re = /^deactivated/i
      if RFIDCode is 'signUp' or RFIDCode.match(re)
        return 'NeedRFID'
    # return 'NeedRFID'
    return 'HaveRFID'
