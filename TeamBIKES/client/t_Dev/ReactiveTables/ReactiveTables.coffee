# Template.ReactiveTables.rendered = ->
#   Meteor.subscribe("DailyBikeDataPub")

Template.ReactiveTables.helpers myCollection: ->
  DailyBikeData.find()