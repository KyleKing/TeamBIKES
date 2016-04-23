# Create editable form
################################################
Forms.mixin(Template.ManageMechanicNotes_Insert)

Template.ManageMechanicNotes_Insert.events
  'documentSubmit': (event, tmpl, doc) ->
    doc.Timestamp = Date.now()
    doc.MechanicID = Meteor.user()._id
    console.log doc
    MechanicNotes.insert(doc)
    FlowRouter.go('/Dashboard')
