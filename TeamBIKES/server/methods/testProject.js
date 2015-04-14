
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