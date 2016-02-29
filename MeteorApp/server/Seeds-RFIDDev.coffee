Meteor.methods 'Create_RFIDtags': ->
  [today, now] = CurrentDay()
  i = 0
  while i < 5
    RFIDtags.insert
      USER_ID: i
      LATITUDE: 38.991057
      LONGITUDE: -76.938113
      LOCKSTATEE: 0
      Module_ID: Fake.word()
      confirmation: 1
      TIMESTAMP: randomNow = now - (10000000 * Math.random())
    i++
  console.log 'Create_RFIDtags: Basic set of RFID IDs'.yellow
