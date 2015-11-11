if RFIDdata.find().count() is 0
  # Useful function from lib/CurrentDay.coffee for current date and time
  [today, now] = CurrentDay()
  i = 0
  while i < 15
    RFIDdata.insert
      USER_ID: 124
      LATITUDE: 38.991057
      LONGITUDE: -76.938113
      LOCKSTATEE: i
      TIMESTAMP: now
    i++
  console.log 'Added RFID Data'





# Manually collected currently and named after team members
Xbeez = [
  ['Kruder', 1, '0013A20040C5F8BA'],
  ['Noh', 2, '0013A20040B90B95'],
  ['LaFond', 3, '0013A20040B7B31F'],
  ['Poh', 4, '0013A20040C5FEB4'],
  ['Fleming', 5, '0013A20040C5F8D1'],
  ['Gilman', 6, '0013A20040B90AD1'],
]

# Check if update is necessary
if XbeeData.find().count() isnt Xbeez.length

  # Useful function from lib/CurrentDay.coffee for current date and time
  [today, now] = CurrentDay()
  XbeeData.remove( { TIMESTAMP: { $lt:  now} } )

  # Insert new Xbee data
  _.each Xbeez, (Xbee) ->
    XbeeObject = {
      'Name': Xbee[0]
      'ID': Xbee[1]
      'Address': Xbee[2]
      'TIMESTAMP': now
    }
    XbeeData.insert XbeeObject

  console.log 'Updated XbeeData with Xbeez'