Template.admin.helpers
  infoTxt: ->
  	# console.log Meteor.userId()
  	# console.log Meteor.users.findOne(Meteor.userId()).roles
  	# console.log Roles.userIsInRole(Meteor.userId(), ['Admin', 'Root'])
  	if Roles.userIsInRole(Meteor.userId(), ['Admin', 'Root'])
  		return "Try clicking on any row to see the interactive functionality"
  	else
			return "Don't see any data? That is because you aren't logged in as an administrator. Try signing out and back in to see all of the wonderful tables and graphs"
