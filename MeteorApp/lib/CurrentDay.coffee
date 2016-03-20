# Helper function called on server and client for current day of year
# needs to be put in lib to load for seed initialization of db
@CurrentDay = ->
  # dateFunc = new Date
  # start = new Date(dateFunc.getFullYear(), 0, 0)
  # diff = dateFunc - start
  # oneDay = 1000 * 60 * 60 * 24
  # day = Math.floor(diff / oneDay)
  # [day, dateFunc.getTime()]

  # console.log day + ' vs ' + moment().utcOffset('-0500').format('DDD')
  # console.log dateFunc.getTime() + ' vs ' + moment().utcOffset('-0500').valueOf()

  offsetTS = moment().utcOffset('-0500')
  today = offsetTS.format('DDD')
  # [ Day of year , time stamp in ms ]
  [Number(today), offsetTS.valueOf()]
