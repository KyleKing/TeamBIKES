Template.navTop.events
  "click button#log-out-btn": (e) ->
    if Meteor.userId()
      AccountsTemplates.logout()
