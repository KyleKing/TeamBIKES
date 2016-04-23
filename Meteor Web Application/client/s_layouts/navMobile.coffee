Template.navMobile.helpers
  'RFIDeh': ->
    if Meteor.user()
      RFIDCode = Meteor.user().profile.RFID
      re = /^deactivated/i
      if RFIDCode is 'signUp' or RFIDCode.match(re)
        return 'NeedRFID'
    return 'HaveRFID'
