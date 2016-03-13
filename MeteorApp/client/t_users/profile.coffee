options = {
  # set helpers to false to disable extending your template with
  # the forms helpers
  helpers: true
  # set events to false to disable extending your template with
  # the forms events (so that no event handlers will be added to
  # your template)
  events: true
  # Set the initial doc for your form
  # doc: {
  #   fullName: 'Kyle Keynesian'
    # telephone: '(###) ###-####'
  # }
  # Set the schema for your form
  schema: {}
}
Forms.mixin(Template.USEFULFORM, options)

Template.USEFULFORM.data = ->
  return {
    fullName: 'Kyle Keynesian'
    telephone: '(###) ###-####'
  }

Template.USEFULFORM.rendered = ->
  tmpl = @
  # tmpl.data = {
  #   fullName: 'Kyle Keynesian'
  #   telephone: '(###) ###-####'
  # }
  form = Forms.instance()
  # for this example we assume that the data context of the template instance contains the document to be edited.
  console.log 'tmpl.data'
  console.log tmpl.data
  form.doc({
    fullName: 'Kyle Keynesian'
    telephone: '(###) ###-####'
  })
  # form.doc(tmpl.data)


Template.USEFULFORM.helpers
  'isBob': ->
    form = Forms.instance()
    console.log "form.doc('fullName')"
    console.log form.doc('fullName')
    return form.doc('fullName') is not 'bob'

Template.USEFULFORM.events
  # Note how propertyChange event passes all changes as a parameter.
  # The parameter contains a set of key-value pairs.
  'propertyChange': (e, tmpl, changes) ->
    if (changes.name)
      Forms.instance().doc('name', changes.name.toUpperCase())
      # the method call above is equivalent to Forms.instance().doc,
      # we use the shorter version here for brevity

  'documentSubmit': (event, tmpl, doc) ->
    # Note that documentSubmit will also pass the validated document
    # as a parameter. This instance of the document object is NOT reactive.
    # Contacts.insert(doc)
    console.log doc
