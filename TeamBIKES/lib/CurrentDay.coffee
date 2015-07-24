# Helper function called on server and client for current day of year
# needs to be put in lib to load for seed initialization of db
@CurrentDay = ->
  dateFunc = new Date
  start = new Date(dateFunc.getFullYear(), 0, 0)
  diff = dateFunc - start
  oneDay = 1000 * 60 * 60 * 24
  day = Math.floor(diff / oneDay)
  [day, dateFunc.getTime()]