DateFormats =
  shortest: 'hh:mm:ss a'
  short: 'hh:mm:ss a M-D-YY'
  long: 'dddd DD.MM.YYYY hh:mm:ss a'
UI.registerHelper 'formatDate', (val, format) ->
  if moment
    # can use other formats like 'lll' too
    format = DateFormats['shortest']
    moment(val).format(format)
  else
    val
