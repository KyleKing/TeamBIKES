DateFormats =
  shortest: 'hh:mm:ss a'
  short: 'hh:mm a MM-DD-YY'
  long: 'dddd DD.MM.YYYY hh:mm a'
UI.registerHelper 'formatDate', (val, format) ->
  if moment
    # can use other formats like 'lll' too
    format = DateFormats[format]
    moment(val).format(format)
  else
    val
