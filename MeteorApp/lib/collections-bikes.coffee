@DailyBikeData = new Mongo.Collection('dailyBikeData')

# Nested Class
nestedPositions = Astro.Class(
  name: 'nestedPositions'
  fields:
    Tag: 'string'
    Rider: 'string'
    Timestamp: 'number'
    Coordinates: 'array'
)
@DailyBikeDatum = Astro.Class(
  name: 'DailyBikeDatum'
  collection: DailyBikeData
  fields:
    Bike:
      type: 'number'
      validator: Validators.and [
        Validators.number()
        Validators.gt(0)
        Validators.lte(100)
      ]
    Day:
      type: 'number'
      validator: Validators.and [
        Validators.number()
        Validators.gt(0)
        Validators.lte(365)
      ]
    Tag:
      type: 'string'
      validator:  Validators.and [
        Validators.string()
        Validators.choice([
          'ToBeRedistributed', 'RepairToBeStarted'
          'RepairInProgress', 'WaitingOnParts', 'Available'
        ])
      ]
    Coordinates:
      type: 'array'
      nested: 'number'
      default: ->
        []
    Positions:
      type: 'array'
      nested: 'nestedPositions'
      default: ->
        []
    transform: (doc) ->
      USER = new User(doc)
      USER.Timestamp = ->
        DateFormats =
          shortest: 'hh:mm:ss a'
          short: 'hh:mm:ss a M-D-YY'
          long: 'dddd DD.MM.YYYY hh:mm:ss a'
        if moment
          format = DateFormats['shortest']
          moment(@Positions[0].Timestamp).format(format)
        else
          @Positions[0].Timestamp
      return USER
)
