FlowRouter.route '/progress',
	name: 'progress',
	action: ->
		BlazeLayout.render 'UniversalLayout', body: 'progress'
FlowRouter.route '/agency',
	name: 'agency',
	action: ->
		BlazeLayout.render 'UniversalLayout', body: 'agency'



###   Public ###
FlowRouter.route '/',
	name: 'about',
	action: ->
		BlazeLayout.render 'UniversalLayout', body: 'about'

### User ###
FlowRouter.route '/Profile',
	name: 'Profile',
	action: ->
		BlazeLayout.render 'UniversalLayout', body: 'Profile'
FlowRouter.route '/map',
	name: 'map',
	action: ->
		BlazeLayout.render 'UniversalLayout', body: 'map'


### Administrator ###
FlowRouter.route '/charts',
	name: 'chartsAdmin',
	action: ->
		BlazeLayout.render 'UniversalLayout', body: 'chartsAdmin'
FlowRouter.route '/RFIDlayout',
	name: 'RFIDlayout',
	action: ->
		BlazeLayout.render 'UniversalLayout', body: 'RFIDlayout'
FlowRouter.route '/mechanicView',
	name: 'mechanicView',
	action: ->
		BlazeLayout.render 'UniversalLayout', body: 'mechanicView'
FlowRouter.route '/timeseries',
	name: 'timeseries',
	action: ->
		BlazeLayout.render 'UniversalLayout', body: 'timeseries'


# DEV - TabularTables
FlowRouter.route '/ManageBikes',
	name: 'ManageBikes',
	action: ->
		BlazeLayout.render 'NavSide', body: 'ManageBikes'

FlowRouter.route '/ManageMechanicNotes',
	name: 'ManageMechanicNotes',
	action: ->
		BlazeLayout.render 'NavSide', body: 'ManageMechanicNotes'

FlowRouter.route '/ManageUsers',
	name: 'ManageUsers',
	action: ->
		BlazeLayout.render 'NavSide', body: 'ManageUsers'