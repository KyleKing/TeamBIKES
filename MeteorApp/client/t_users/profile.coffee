# # Template.profile.rendered = ->
# #   L.Icon.Default.imagePath = 'packages/bevanhunt_leaflet/images'
# #   KyleMap = new L.map('kyle').setView([49.25044, -123.137], 13)
# #   L.tileLayer.provider('OpenStreetMap.Mapnik').addTo(KyleMap)

# #   KyleMapbutton = L.easyButton('fa-globe fa-lg', (btn, map) ->
# #     console.log map
# #     alert('Map center is at: ' + map.getCenter().toString())
# #   ).addTo(KyleMap)




# # Template.userform.onCreated ->
# #   _id = FlowRouter.getParam('_id')
# #   if _id
# #     @subscribe 'user', _id
# #     @data.user = new ReactiveVar(Users.findOne(_id))
# #   else
# #     @data.user = ReactiveVar(new User)

# Template.userform.events
#   'change input': (e, tmpl) ->
#     doc = this
#     # Instance of User, Phone or Address class.
#     # Get an input which value was changed.
#     input = e.currentTarget
#     # Set a value of a field in an instance of User, Phone or Address class.
#     doc.set input.id, input.value
#     # Validate given field.
#     doc.validate input.id

#   'click [name=addPhone]': (e, tmpl) ->
#     user = tmpl.data.user.get()
#     # FIXME: It should be:
#     # user.push('phones', new Phone());
#     # However, it will not work because of trying to modify the same field with
#     # two different modifiers. I have to implement modifiers merging.
#     user.phones.push new Phone
#     tmpl.data.user.set user

#   'click [name=removePhone]': (e, tmpl) ->
#     user = tmpl.data.user.get()
#     user.pull 'phones', this
#     tmpl.data.user.set user

#   'click [name=save]': (e, tmpl) ->
#     user = tmpl.data.user.get()
#     if user.validate()
#       Meteor.call '/user/save', user, (err) ->
#         if !err
#           FlowRouter.go 'users'
#         else
#           user.catchValidationException err
