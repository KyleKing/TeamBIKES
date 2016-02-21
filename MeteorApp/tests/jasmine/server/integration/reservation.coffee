describe 'Reservation', ->
  beforeEach ->
    Meteor.call('CreateDailyBikeData', 30, 1)
  afterEach ->
    Meteor.call('DestroyDailyBikeData')

  it 'Should only reserve one bike at a time and clear repeats', (done) ->
    # Example Insert-Jack
    # spyOn(Tutorials, "insert").and.callFake(function(doc, callback) {
    #     // simulate async return of id = "1";
    #     callback(null, "1");
    # });
    #
    # spyOn(Roles, "userIsInRole").and.returnValue(true);
    # spyOn(Tutorials, "remove");
    # spyOn(TutorialRegistrations, "find").
    #   and.returnValue({count: function() { return 2 }});

    # Remove Multiple Reservations
    fakeUserID = 'testingIDtesting'
    bike1 = DailyBikeData.findOne({Tag: "Available"})
    bike1.set({ Tag: fakeUserID })
    bike1.save()
    bike2 = DailyBikeData.findOne({Tag: "Available"})
    bike2.set({ Tag: fakeUserID })
    bike2.save()

    # Make sure that two bikes are reserved:
    count1 = DailyBikeData.find({Tag: fakeUserID}).count()
    expect( count1 ).toEqual(2)

    # Create a single reservation
    bike3 = DailyBikeData.findOne({Tag: "Available"})
    Bike = bike3.Bike
    Meteor.call('UserReserveBike', fakeUserID, Bike)
    # Alt, if test through UI: ('.awesome-marker.leaflet-clickable')
    foundTag = DailyBikeData.findOne({Bike: Bike}).Tag
    expect( foundTag ).toEqual(fakeUserID)

    # Then check to make sure that bike 2 is not reserved
    count2 = DailyBikeData.find({Tag: fakeUserID}).count()
    expect( count2 ).toEqual(1)
    done()

  # it 'Should clear bike rental after set amount of time', (done) ->
  #   # Create a single reservation
  #   fakeUserID = 'testingIDtesting'
  #   bike = DailyBikeData.findOne({Tag: "Available"})
  #   Bike = bike.Bike
  #   timeout = 5
  #   future = moment().add( timeout, 'minutes' ).format()
  #   # Meteor.call('CreateTask', fakeUserID, Bike, timeout, future)
  #   # Meteor.call('UserReserveBike', fakeUserID, Bike)
  #   Meteor.call('StartReservationCountdown', fakeUserID, Bike)

  #   expect( true ).toEqual(true)

  #   # foundTag = DailyBikeData.findOne({Bike: Bike}).Tag
  #   # try
  #   #   expect( foundTag ).toEqual(fakeUserID)
  #   # catch err
  #   #   throw err

  #   done()
