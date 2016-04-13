# ###*******************************************###

# ###   TODO: Check for accounts without an RFID field and call this function          ###

# # Use: http://docs.mongodb.org/manual/reference/operator/query/exists/
# # $exists: false

# ###******************************************###

# Meteor.methods 'RFIDStreamData': (dataSet) ->
#   # Update MongoDB data based on bike number
#   record = RFIDdata.find().fetch()[0]
#   RFIDdata.insert
#     RFIDCode: dataSet.RFIDCode
#     time: dataSet.time
#   # Example Code:
#   # encrypted = CryptoJS.AES.encrypt(dataSet.RFIDCode.toString(), 'Dino');
#   # console.log(encrypted.toString());
#   key = 'Dino'
#   message = 'hi'
#   encrypted = CryptoJS.AES.encrypt(message, key)
#   console.log encrypted.toString()
#   # 53616c7465645f5fe5b50dc580ac44b9be85d240abc5ff8b66ca327950f4ade5
#   decrypted = CryptoJS.AES.decrypt(encrypted, key)
#   console.log decrypted.toString(CryptoJS.enc.Utf8)
#   # Message
#   encrypted.toString()

Meteor.methods 'RFIDStreamData': (dataSet) ->
  console.log '--------------------'
  # Check user RFID code against database record set in seeds-admin
  RFIDCODE = dataSet.USER_ID
  hits = Meteor.users.find({'profile.RFID': RFIDCODE}).count()
  dataSet.confirmation = hits

  # console.log '>> Here are the users RFID dataset:'
  users = Meteor.users.find().fetch()
  # _.each users, (user) ->
    # console.log user.profile.RFID

  # Determine appropriate response
  if hits is 1
    data = 'y'
  else
    data = 'n'

  # Lookup = XbeeData.findOne({ 'ID': Number(dataSet.Module_ID) })
  Lookup = XbeeData.findOne({ 'Name': dataSet.Module_ID })

  if Lookup
    console.log 'Just to check that Lookup is receiving data'.lightMagenta
    console.log data
    console.log Lookup.Address
    dataSet.Address = Lookup.Address

  ReservationEvents.insert(dataSet)
  console.log 'Added incoming dataset to ReservationEvents collection'

  if Lookup
    return {
      data: data,
      Address: Lookup.Address
    }
  else
    return {}

Meteor.call('RFIDStreamData', {
  USER_ID: 'signUp'
  LATITUDE: 12134.234234
  LONGITUDE: '12134.234234'
  LOCKSTATE: 0
  Module_ID: 'TEST'
  TIMESTAMP: (new Date).getTime()
})
