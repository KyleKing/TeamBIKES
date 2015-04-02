/*****************/
/*  Admin View         */
/*****************/

  // Mechanic Filler Data
  RandNames = new Meteor.Collection('randNames');
  RandMechanicNames = new Meteor.Collection('randMechanicNames');
  // Bike data used in mechanic layout
  Bikes = new Mongo.Collection('bikes'); // Create new bikes collection for inventory
  // RFID Confirmation and Storage Test Data
  RFIDdata = new Meteor.Collection('rfidData');

  /************************/
  /*  Sample Chart Data          */
  /************************/
    // Used in user profile
    BarChart = new Meteor.Collection('barchart');
    AdminBarChart = new Meteor.Collection('adminbarchart');
    AdminAreaChart = new Meteor.Collection('adminareachart');

  /************************/
  /*  Named Admin Views          */
  /************************/
  // Admin 2 and Admin 3
  TestUsers = new Meteor.Collection('testUsers');
  // Subscription call inside charts-admin/chartsAdmin.js
  TimeSeries = new Meteor.Collection('timeseries'); // Time series data

  // chartsAdmin.js
  /*********************************************/
  /*   Demo collection for login info                             */
  /********************************************/
  Information = new Meteor.Collection('information');
  SortTime = new Meteor.Collection('sortTime'); // see sort time function below


/*****************/
/*  User View          */
/*****************/

  // Map data
  Current = new Meteor.Collection('current'); // One set of public data


/*********************************************/
/*  Meteor Methods (server side code called from client)  */
/********************************************/

// Testing sorting of array of documents
if (Meteor.isServer) {
  Meteor.methods({
    sortTime: function () {
      var pipeline = [
        { $match: {bike: 4} },
        { $unwind: '$positions' },
        { $sort: {'positions.timestamp': -1} },
        { $group: {_id : "$bike", positions: {$push: '$positions'}} }
      ];
      var Bike = TimeSeries.aggregate(pipeline);
      // var pipeline = [
      //   { $group : { _id : "$positions.timestamp", positions: { $push: "$positions.Lat" } } }
      //   // { $match: { bike: num} },
      //   // { $unwind: '$positions' },
      //   // { $sort: {'positions.timestamp': -1} }
      //   // { $out: "sortedTime" } // Not yet supported in Meteor
      // ];
      // var Bike = TimeSeries.aggregate(pipeline);

      SortTime.insert({
        email: 'Kyle@email.com',
        meal: Bike[0]._id,
        data: 4,
        lunch: 12
      });
    }
  });


  // Called by Admin 3
  Meteor.methods({
    eachBike: function () {
      // For each bike (10), match and unwind into usable format
      for (var BikeNum = 1; BikeNum <= 10; BikeNum++) {
        var Bikes = TimeSeries.aggregate([
          { $match: {bike: BikeNum} },
          { $unwind: '$positions' },
          { $sort: {'positions.timestamp': 1} },
          { $group: {_id : "$positions.user", positions: {$push: '$positions'} } }
        ]);
        /*********************************************/
        /*   This should be including every bike with the same bike number regardless of day value, but it isn't */
        /* Possibly due to the _id */
        /********************************************/
        // console.log(Bikes);

        // for each bike (scalable), ...
        _(Bikes).each(function(Bike) {
          if (Bike._id) { // Ignore blank strings (i.e. no user)
            var record = TestUsers.findOne({User: Bike._id});
            var positionsData = []; var rides = 0;
            _(Bike.positions).each(function(position) {
              positionsData.push({bike: BikeNum, timestamp: position.timestamp,  user: position.user, lat: position.lat, lng: position.lng});
              rides = rides + 1;
            });
            if (!record) {
              TestUsers.insert({
                user: Bike._id,
                rides: rides,
                positions: positionsData
              });
            } else {
              _(Bike.positions).each(function(position) {
                if (!TestUsers.findOne({'positions.timestamp': position.timestamp})) {
                  positionsData = {bike: BikeNum, timestamp: position.timestamp,  user: position.user, lat: position.lat, lng: position.lng};
                  TestUsers.update(
                    record, {
                      $addToSet: {positions: positionsData},
                      $inc: {rides: 1}
                    }
                  );
                }
              });
            }
          }
        });
      }
    }
  });

} // end Meteor.isServer