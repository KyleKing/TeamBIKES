Template.ManageMechanicNotes_Form.onCreated ->
  # Use this.subscribe inside onCreated callback
  @subscribe 'ManageMechanicNotes'

Template.ManageMechanicNotes_Form.helpers
  # Return the id of selected row
  SelectedRow: ->
    MechanicNotes.findOne {_id: FlowRouter.getParam ("IDofSelectedRow") }
  noteFact: ->
    MechanicNotes.find {_id: FlowRouter.getParam ("IDofSelectedRow") }


# Create editable form
################################################
Forms.mixin(Template.ManageMechanicNotes_Form)

Template.ManageMechanicNotes_Form.events
  'documentSubmit': (event, tmpl, doc) ->
    console.log doc.note
    if doc.note
      if doc.note.length is 0
        throw new Error("Can't submit an empty report")
      else
        MechanicNotes.update(
          {_id: FlowRouter.getParam ("IDofSelectedRow") },
          {$set: { 'Notes': doc.note }}
        )
  'click #removeMechNote': ->
    MechanicNotes.remove(_id: FlowRouter.getParam ("IDofSelectedRow"))
    FlowRouter.go('/Dashboard')