[today, now] = CurrentDay()
Meteor.methods 'Create_XbeeData': ->
  # Manually collected and named after team members
  Xbeez = [
    ['Kruder', 1, '0013A20040C5F8BA'],
    ['Noh', 2, '0013A20040B90B95'],
    ['LaFond', 3, '0013A20040B7B31F'],
    ['Poh', 4, '0013A20040C5FEB4'],
    ['Fleming', 5, '0013A20040C5F8D1'],
    ['Gilman', 6, '0013A20040B90AD1'],
  ]
  if XbeeData.find().count() isnt Xbeez.length
    Meteor.call('Delete_XbeeData')
    _.each Xbeez, (Xbee) ->
      XbeeObject = {
        'Name': Xbee[0]
        'ID': Xbee[1]
        'Address': Xbee[2]
        'TIMESTAMP': now
      }
      XbeeData.insert XbeeObject
    console.log 'Create_XbeeData: Refreshed XbeeData with manual list'.lightYellow
