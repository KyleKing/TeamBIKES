describe 'seedData', ->
  it 'Should Create Meteor.users then Clear it', (done) ->
    Meteor.call('Create_Users')
    expect( Meteor.users.find().count() ).toEqual(5)
    Meteor.call('Delete_Users')
    expect( Meteor.users.find().count() ).toEqual(0)
    done()

  it 'Should Create DailyBikeData then Clear it', (done) ->
    Meteor.call('Create_DailyBikeData')
    expect( DailyBikeData.find().count() ).toEqual(200)
    Meteor.call('Delete_DailyBikeData')
    expect( DailyBikeData.find().count() ).toEqual(0)
    done()

  it 'Should Create RackNames then Clear it', (done) ->
    Meteor.call('Create_RackNames')
    Meteor.setTimeout (->
      expect( RackNames.find().count() ).toEqual(285)
      Meteor.call('Delete_RackNames')
      expect( RackNames.find().count() ).toEqual(0)
      done()
    ), 500

  it 'Should Create OuterLimit then Clear it', (done) ->
    Meteor.call('Create_OuterLimit')
    expect( OuterLimit.find().count() ).toEqual(30)
    Meteor.call('Delete_OuterLimit')
    expect( OuterLimit.find().count() ).toEqual(0)
    done()

  it 'Should Create RFIDtags then Clear it', (done) ->
    Meteor.call('Create_RFIDtags')
    expect( RFIDtags.find().count() ).toEqual(10)
    Meteor.call('Delete_RFIDtags')
    expect( RFIDtags.find().count() ).toEqual(0)
    done()

  it 'Should Create MechanicNotes then Clear it', (done) ->
    Meteor.call('Create_MechanicNotes')
    expect( MechanicNotes.find().count() ).toEqual(4)
    Meteor.call('Delete_MechanicNotes')
    expect( MechanicNotes.find().count() ).toEqual(0)
    done()

  it 'Should Create XbeeData then Clear it', (done) ->
    Meteor.call('Create_XbeeData')
    expect( XbeeData.find().count() ).toEqual(6)
    Meteor.call('Delete_XbeeData')
    expect( XbeeData.find().count() ).toEqual(0)
    done()
