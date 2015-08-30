# Cron scheduling experimentation

# In this case, "details" should be an object containing a date,
# plus required e-mail details (recipient, content, etc.)

# sendMail = (details) ->
#   Email.send
#     from: details.from
#     to: details.to
#   return



Meteor.startup ->
	SyncedCron.add
	  name: 'Update DB'
	  schedule: (parser) ->
	    # parser is a later.parse object
	    parser.text 'at 2:01 am'
	  job: ->
	    PopulateDailyBikeData()
  SyncedCron.start()
  return
