# Useful utilities used mostly in creating seed data
# Set in global, window scope
@myUtilities = {
  randName: ->
    # Return a random name
    AllRandNames = [
      'Anastasia Romanoff', 'Marie Antoinette', 'Chuff Chuffington'
      'Kate Middleton', 'Harry Potter', 'Snow White', 'Lake Likesscooters'
      'Pippa Middleton', 'Napoleon Bonapart', 'Britany Bartsch'
      'Roselee Sabourin', 'Chelsie Vantassel', 'Chaya Daley', 'Luella Cordon'
      'Jamel Brekke', 'Jonie Schoemaker', 'Susannah Highfield'
      'Mitzi Brouwer', 'Forrest Lazarus', 'Dortha Dacanay', 'Delinda Brouse'
      'Alyssa Castenada', 'Carlo Poehler', 'Cicely Rudder', 'Lorraine Galban'
      'Trang Lenart', 'Patrica Quirk', 'Zackary Dedios', 'Ursula Kennerly'
      'Shameka Flick', 'President Loh'
    ]
    AllRandNames[ Math.round( (AllRandNames.length - 1) * Math.random() ) ]


  randTag: ->
    if Math.round(0.75 * Math.random()) is 0
      if Math.round(1.1 * Math.random()) is 0
        RandTag = 'rndtag'
      else
        RandTag = 'Available'
    else
      RandTag = 'RepairInProgress'
    # Other options: ToBeRedistributed, RepairToBeStarted,
    #       RepairInProgress, WaitingOnParts, Available
    RandTag


  randGPS: (max) ->
    # Calculate random GPS coordinates within campus limits

    # Bottom Right: Latitude : 38.980296 | Longitude : -76.933479
    # Bottom Left: Latitude : 38.982297 | Longitude : -76.957941
    # Top Left: Latitude : 38.999109 | Longitude : -76.956053
    # Top Right: Latitude : 39.003778 | Longitude : -76.932278
    leftLat = 38.994052
    rightLat = 38.981376
    bottomLng = -76.936569
    topLng = -76.950603
    randLat = []
    randLng = []
    # Convert to integers
    sigfig = 1000000

    # Generate an array of: [lat, lng] with the size of 'max'
    _.times max, ->
      randLat.push _.random(leftLat * sigfig, rightLat * sigfig) / sigfig
    _.times max, ->
      randLng.push _.random(bottomLng * sigfig, topLng * sigfig) / sigfig
    [Number(randLat), Number(randLng)]
}