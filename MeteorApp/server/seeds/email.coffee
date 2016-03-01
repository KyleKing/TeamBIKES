# Send an email only to myself:
Meteor.methods 'sendEmailUpdate': (subject, text) ->
  check [ subject, text ], [ String ]
  @unblock()
  Email.send
    to: 'kmking72@gmail.com'
    from: 'kmking72@gmail.com'
    subject: subject
    text: text

# For everything else:
Meteor.methods 'sendEmail': (to, from, subject, text) ->
  check [ to, from, subject, text ], [ String ]
  # Let other method calls from the same client start running,
  # without waiting for the email sending to complete.
  @unblock()
  Email.send
    to: to
    from: from
    subject: subject
    text: text
