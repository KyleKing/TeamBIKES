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
	    # parser.text 'at 2:01 am'
	    parser.text 'at 7:10 pm'
	  job: ->
	    numbersCrunched = 12
	    console.log numbersCrunched
	    numbersCrunched
  SyncedCron.start()
  return
