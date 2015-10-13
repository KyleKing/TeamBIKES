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
