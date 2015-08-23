Template.ManageBikes.events 'click tbody > tr': (event) ->
	# Store the id of the row clicked by the user
	dataTable = $(event.target).closest('table').DataTable()
	rowData = dataTable.row(event.currentTarget).data()
	Session.set "IDofSelectedRowBikes", rowData._id
	FlowRouter.go('/ManageBike/' + rowData._id)

	# # Provide user feedback with a highlighted
	# $('.selected').removeClass 'selected'
	# $(event.currentTarget).toggleClass 'selected'

Template.ManageBikes.helpers
	# Return the id of selected row
	# SelectedRow: ->
		# DailyBikeData.findOne {_id: Session.get "IDofSelectedRowBikes"}
	selector: ->
		[today, now] = CurrentDay()
		{ Day: today }

# Template.ManageBikes.onCreated ->
#   # Use this.subscribe inside onCreated callback
#   @subscribe 'DailyBikeDataPub'