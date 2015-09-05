Template.ReactiveTables.rendered = ->
  Meteor.subscribe("DailyBikeDataPub")

Template.ReactiveTables.helpers settings: ->
  return {
      collection: DailyBikeData
      rowsPerPage: 4
      showFilter: true
  		filters: ['myFilter']
      # fields: ['name', 'location', 'year']
  }
