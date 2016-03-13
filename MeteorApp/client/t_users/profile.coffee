Forms.mixin(Template.USEFULFORM)

Template.USEFULFORM.rendered = ->
  form = Forms.instance()
  form.doc({
    fullName: 'Kyle Keynesian'
    telephone: '(###) ###-####'
  })

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
