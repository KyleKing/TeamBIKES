fill = (email) ->
	$("#at-field-email").val(email)
	$("#at-field-password").val("password")

Template.loginForm.events
  "click button": (e) ->
  	switch e.currentTarget.id
		  when "admn" then fill("admin@theboss.com")
		  when "user" then fill("biker123456789@example.com")
		  when "mech" then fill("mechanic@wrenchwrench.com")
		  else throw "No recognized id"

# Accounts.onLogin(function () {
#     Meteor.logoutOtherClients(function(){
#        Router.go('/');
#    });
# });