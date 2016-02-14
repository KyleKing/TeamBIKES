describe 'Reservation', ->
  beforeEach ->
    Meteor.call('CreateDailyBikeData', 10, 1)
  afterEach ->
    Meteor.call('DestroyDailyBikeData')

  it 'still needs unit tests', ->
    expect(true).toEqual true

  it 'should reserve a bike', (done) ->
    # Meteor.setTimeout (->
    # Example Insert-Jack
    # spyOn(Tutorials, "insert").and.callFake(function(doc, callback) {
    #     // simulate async return of id = "1";
    #     callback(null, "1");
    # });
    #
    # spyOn(Roles, "userIsInRole").and.returnValue(true);
    # spyOn(Tutorials, "remove");
    # spyOn(TutorialRegistrations, "find").and.returnValue({count: function() { return 2 }});

    bike = DailyBikeData.findOne({Tag: "Available"})
    currentUserId = 'testingIDtesting'
    Bike = bike.Bike
    Meteor.call('UserReserveBike', currentUserId, Bike)

    # Alt, if test through UI: ('.awesome-marker.leaflet-clickable')
    # expect( count ).toEqual 0
    expect( DailyBikeData.findOne({Bike: Bike}).Tag ).toEqual currentUserId
    done()
    # ), 1000
