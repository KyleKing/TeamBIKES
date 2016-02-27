fill = (email) ->
	$("#at-field-email").val(email)
	$("#at-field-password").val("password")

Template.loginForm.events
  "click button": (e) ->
  	# console.log e.currentTarget
  	id = e.currentTarget.id
  	switch id
		  when "admn" then fill("admin@theboss.com")
		  when "user" then fill("biker123456789@example.com")
		  when "mech" then fill("mechanic@wrenchwrench.com")
		  else throw "No recognized id: " + id
		# Submit form with programmatically filled fields (optional):
		# Actually doesn't work because not in loginForm template?
		# document.forms[0].submit()
		# $("#at-btn").click()

# Accounts.onLogin(function () {
#     Meteor.logoutOtherClients(function(){
#        Router.go('/');
#    });
# });