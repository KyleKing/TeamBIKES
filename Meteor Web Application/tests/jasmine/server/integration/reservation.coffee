describe 'Reservation', ->
  beforeEach ->
    Meteor.call('CreateDailyBikeData', 45, 1)
  afterEach ->
    Meteor.call('Delete_DailyBikeData')

  it 'Should make a basic reservation', (done) ->
    # Create a single reservation
    fakeUserID = 'FirstTestingID'
    bike = DailyBikeData.findOne({Tag: "Available"})
    Bike = bike.Bike
    Meteor.call('UserReserveBike', fakeUserID, Bike)
    # Alt, if test through UI: ('.awesome-marker.leaflet-clickable')
    foundTag = DailyBikeData.findOne({Bike: Bike}).Tag
    expect( foundTag ).toEqual(fakeUserID)
    done()



  it 'Should clear bike rental after set amount of time', (done) ->
    # Create a single reservation
    fakeUserID = 'SecondTestingID'
    record = DailyBikeData.findOne({Tag: "Available"})
    try
      record.set({Tag: fakeUserID})
      record.save()
    catch err
      errMessage = 'No Bike Record Found in Method "UserReserveBike": ' + err
      throw errMessage

    # Create cron task to delete reservation at set time interval
    Bike = record.Bike
    timeout = 2
    future = moment().add( timeout, 'seconds' ).format()
    # Other methods that "Should Work"
    # Meteor.call('UserReserveBike', fakeUserID, Bike)
    # Meteor.call('StartReservationCountdown', fakeUserID, Bike)
    try
      Meteor.call('CreateTask', fakeUserID, Bike, timeout, future)
    catch err
      throw err
    foundTag = DailyBikeData.findOne({Bike: Bike}).Tag
    expect( foundTag ).toEqual(fakeUserID)

    Meteor.setTimeout (->
      foundTag = DailyBikeData.findOne({Bike: Bike}).Tag
      try
        expect( foundTag ).toEqual( 'Available' )
      catch err
        console.warn 'Error: foundTag = ' + foundTag
        throw err
      done()
    ), timeout * 1000



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
    fakeUserID = 'ThirdTestingID'
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
    foundTag = DailyBikeData.findOne({Bike: Bike}).Tag
    expect( foundTag ).toEqual(fakeUserID)

    # Then check to make sure that bike 2 is not reserved
    count2 = DailyBikeData.find({Tag: fakeUserID}).count()
    expect( count2 ).toEqual(1)
    done()
