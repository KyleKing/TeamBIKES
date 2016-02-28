Template.admin.helpers
  infoTxt: ->
  	# console.log Meteor.userId()
  	# console.log Meteor.users.findOne(Meteor.userId()).roles
  	# console.log Roles.userIsInRole(Meteor.userId(), ['Admin', 'Root'])
  	if Roles.userIsInRole(Meteor.userId(), ['Admin', 'Root'])
  		return "Try clicking on any row to see the interactive functionality"
  	else
  		phrase = "Don't see any data? That is because you don't" +
        ' have permission as a "' +
  			Meteor.users.findOne(Meteor.userId()).roles[0] +
  			'." Try signing in under a different account and see how the view changes.'
			return phrase
