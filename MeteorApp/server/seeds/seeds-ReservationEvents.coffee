Meteor.methods 'Create_ReservationEvents': ->
  ReservationEvents.insert({
    USER_ID: 'Kyle'
    LATITUDE: 12134.234234
    LONGITUDE: '12134.234234'
    LOCKSTATE: 1
    Module_ID: 'asf23ry23ihbdhflaksd'
    TIMESTAMP: (new Date).getTime()
  })
  console.log 'Create_ReservationEvents: Basic Raspberry Pi Event'.lightYellow
