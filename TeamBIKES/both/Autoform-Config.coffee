if Meteor.isClient
	hooksObject =
		# before: formType: (doc) ->
		#   # Potentially alter the doc
		#   doc.foo = 'bar'
		#   # Then return it or pass it to this.result()
		#   #return doc; (synchronous)
		#   #return false; (synchronous, cancel)
		#   #this.result(doc); (asynchronous)
		#   #this.result(false); (asynchronous, cancel)
		#   return
		# after: formType: (error, result) ->
		# onSubmit: (insertDoc, updateDoc, currentDoc) ->
		#   # You must call this.done()!
		#   #this.done(); // submitted successfully, call onSuccess
		#   #this.done(new Error('foo')); // failed to submit, call onError with the provided error
		#   #this.done(null, "foo"); // submitted successfully, call onSuccess with `result` arg set to "foo"
		#   FlowRouter.go('AdminCompilation')
		#   @done()
		#   return
		#
		onSuccess: (formType, result) ->
			$('.cd-panel').removeClass 'is-visible'
			# Stopped re-routing as this only loses information on route and has the down side of flashing placeholder text
			# FlowRouter.go('AdminCompilation')
			#
		# onError: (formType, error) ->
		# formToDoc: (doc) ->
		#   # alter doc
		#   # return doc;
		#   return
		# formToModifier: (modifier) ->
		#   # alter modifier
		#   # return modifier;
		#   return
		# docToForm: (doc, ss) ->
		# beginSubmit: ->
		# endSubmit: ->

	AutoForm.addHooks(['insertMechanicNotesForm', 'updateMechanicNotesForm', 'updateMeteorUsersForm'], hooksObject)