# #Generates random data using Faker.js
# #Runs before main.coffee
# @Items = new Meteor.Collection "items"
# N = 1000
# if Meteor.isServer and @Items.find().count() isnt N
#   @Items.remove {}
#   for i in [1 .. N]
#     @Items.insert _.pick faker.helpers.createCard(), "name", "username", "email", "phone", "website"


# #The Items collection has been created in testdata.coffee
# fields = ["name", "username", "email", "phone", "website"]
# @Pages = new Meteor.Pagination Items,
#   dataMargin: 5
#   fastRender: true
#   perPage: 20
#   router: 'iron-router'
#   homeRoute: '/items/'
#   routerTemplate: 'items'
#   routerLayout: 'appLayout'
#   sort:
#     name: 1
#   table:
#     class: "table"
#     fields: fields
#     header: _.map fields, (f) -> f[0].toUpperCase() + f.slice 1 #Capitalize fields
#     wrapper: "table-wrapper"