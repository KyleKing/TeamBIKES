fill = (email) ->
  $("#at-field-email").val(email)
  $("#at-field-password").val("password")

Template.loginForm.events
  "click button.fill-login": (e) ->
    # console.log e.currentTarget
    id = e.currentTarget.id
    switch id
      when "root" then fill("root@example.com")
      when "admn" then fill("admin@theboss.com")
      when "user" then fill("biker123456789@example.com")
      when "mech" then fill("mechanic@wrenchwrench.com")
      else throw new Error("No recognized id: " + id)
