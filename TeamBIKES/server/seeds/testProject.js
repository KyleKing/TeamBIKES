var totalBikeCount = 200;

// Calculate current day of year without momentjs
  // Copied from: http://stackoverflow.com/questions/8619879/javascript-calculate-the-day-of-the-year-1-366
var currentDay = (function() {
  var dateFunc = new Date();
  var start = new Date(dateFunc.getFullYear(), 0, 0);
  var diff = dateFunc - start;
  var oneDay = 1000 * 60 * 60 * 24;
  var day = Math.floor(diff / oneDay);
  return day;
});

var now = new Date().getTime();

  // Bottom Right: Latitude : 38.980296 | Longitude : -76.933479
  // Bottom Left: Latitude : 38.982297 | Longitude : -76.957941
  // Top Left: Latitude : 38.999109 | Longitude : -76.956053
  // Top Right: Latitude : 39.003778 | Longitude : -76.932278
var randGPS = (function(max) {
  // Calculate random GPS coordinates within campus
  var leftLat = 38.994052;
  var rightLat = 38.981376;
  var bottomLng = -76.936569;
  var topLng = -76.950603;
  var skew = 1000000;

  var randLat = [];  var randLng = [];
  _.times(max, function(){ randLat.push(_.random(leftLat*skew, rightLat*skew)/skew); });
  _.times(max, function(){ randLng.push(_.random(bottomLng*skew, topLng*skew)/skew); });

  // Save in object to return
  var randCoordinates = {lat: randLat, lng: randLng};
  return randCoordinates;
});
// console.log(randGPS(25).lng[Math.round(24*Math.random())]);

var randNames = [
  'Anastasia Romanoff',
  'Marie Antoinette',
  'Chuff Chuffington',
  'Kate Middleton',
  'Harry Potter',
  'Snow White',
  'Lake Likesscooters',
  'Pippa Middleton',
  'Napoleon Bonapart',
  'Britany Bartsch',
  'Roselee Sabourin',
  'Chelsie Vantassel',
  'Chaya Daley',
  'Luella Cordon',
  'Jamel Brekke',
  'Jonie Schoemaker',
  'Susannah Highfield',
  'Mitzi Brouwer',
  'Forrest Lazarus',
  'Dortha Dacanay',
  'Delinda Brouse',
  'Alyssa Castenada',
  'Carlo Poehler',
  'Cicely Rudder',
  'Lorraine Galban',
  'Trang Lenart',
  'Patrica Quirk',
  'Zackary Dedios',
  'Ursula Kennerly',
  'Shameka Flick',
  'President Loh',
  '','','','','','','','','','','','','','','','','','','','','','','','','','','','',
  '','','','','','','','','','','','','','','','','','','','','','','','','','','','',
  '','','','','','','','','','','','','','','','','','','','','','','','','','','','',
  '','','','','','','','','','','','','','','','','','','','','','','','','','','','',
  '','','','','','','','','','','','','','','','','','','','','','','','','','','',''];

if(RandNames.find().count() === 0) {
  RandNames.insert({
    names: _.without(randNames, '')
    // .slice(0, 31)
  });
}

// Insert database of bikes if no data for today
if (TimeSeries.find({day: currentDay()}).count() === 0) {
  for (var i = 1; i <= totalBikeCount; i++) {
    // create template for each timeseries data stored
    var position = []; var randomNow = NaN; var blank = {};
    for (var countTime = 0; countTime < 30; countTime++) { // For 60 minutes in an hour
      randomNow = now - 10000000*Math.random();
      // console.log('i = ' + i);
      var namePoint = Math.round((randNames.length-1)*Math.random());
      // console.log('randNames = ' + randNames);
      var randGPSPoint = Math.round(1*Math.random());
      blank = {
        user: randNames[namePoint],
        timestamp: randomNow,
        lat: randGPS(2).lat[randGPSPoint],
        lng: randGPS(2).lng[randGPSPoint]
      };
      // console.log('name = ' + blank.User);
      position.push(blank); // create array
    }
    TimeSeries.insert({
      bike: i,
      status: (Math.round(0.65*Math.random()) === 0 ? 'Fine' : 'Bad'),
      day: currentDay(),
      positions: position
    });
  }
  console.log("Created TimeSeries dataschema");
}

var status = [
  'Scrap',
  'Waiting for Repair',
  'Fixed', 'Fixed', 'Fixed', 'Fixed',
  'Available', 'Available', 'Available',
  'Available', 'Available', 'Available',
  'Available', 'Available', 'Available',
  'Available', 'Available', 'Available',
  'Available', 'Available', 'Available',
  'Available', 'Available', 'Available',
  'In Use', 'In Use', 'In Use',
  'In Use', 'In Use', 'In Use',
  'In Use', 'In Use', 'In Use',];

var partslist = [
  'Bottom Bracket',
  'Stacks of cash',
  'Stem post',
  'Handlebar' ];

var mechanicNotes = [
  'Broken spokes, all of them',
  'Flat tire',
  'Broken stem',
  'Broken seatpost, someone was too heavy',
  'Tuneup', 'Tuneup', 'Tuneup', 'Tuneup', 'Tuneup', 'Tuneup',
  'Tuneup', 'Tuneup', 'Tuneup', 'Tuneup', 'Tuneup', 'Tuneup',
  'Tuneup', 'Tuneup', 'Tuneup', 'Tuneup', 'Tuneup', 'Tuneup',
  'Tuneup', 'Tuneup', 'Tuneup', 'Tuneup', 'Tuneup', 'Tuneup',
  'Built from box', 'Built from box' ];

var mechanics = [{
    name: 'Erlene Pettit',
    role: 'Administrator'
  }, {
    name: 'Ingrid Carney',
    role: 'Mechanic'
  }, {
    name: 'Cassondra Chau',
    role: 'Mechanic'
  }, {
    name: 'Katharina Pearce',
    role: 'Mechanic'
  }, {
    name: 'Thomasina Dye',
    role: 'Mechanic'
  }, {
    name: 'Melda Miranda',
    role: 'Mechanic'
  }, {
    name: 'Doretha Bayne',
    role: 'Mechanic'
  }, {
    name: 'Ester Newkirk',
    role: 'Mechanic'
  }, {
    name: 'Wynell Rosa',
    role: 'Mechanic'
  }, {
    name: 'Chadwick Slade',
    role: 'Mechanic'
  }];

if(RandMechanicNames.find().count() === 0) {
  RandMechanicNames.insert({
    staff: mechanics
  });
}

// Insert database of bikes if no data for today
if (Bikes.find({month: currentDay()}).count() === 0) {
  for (var i = 1; i <= totalBikeCount; i++) {
    // create template for each Bikes data stored
    var update = []; var randomNow = NaN; var blank = {};
    for (var countTime = 0; countTime < 30; countTime++) { // For 60 minutes in an hour
      randomNow = now - 10000000*Math.random();
      var randGPSPoint = Math.round(1*Math.random());
      blank = {
        status: status[_.random(0,status.length - 1)],
        mechanicNotes: mechanicNotes[_.random(0,mechanicNotes.length - 1)],
        partslist: partslist[_.random(0,partslist.length - 1)],
        mechanic: mechanics[_.random(0,9)].name,
        role: mechanics[_.random(0,9)].role,
        timestamp: randomNow,
        lat: randGPS(2).lat[randGPSPoint],
        lng: randGPS(2).lng[randGPSPoint]
      };
      // console.log('name = ' + blank.User);
      update.push(blank); // create array
    }
    Bikes.insert({
      bike: i,
      month: currentDay(),
      updates: update
    });
  }
  console.log("Created Bikes dataschema");
}

if (Current.find().count() === 0) {
  // console.log("Starting MongoDB with math!");
  for (var i = 0; i < totalBikeCount; i++) { // For 10 bikes
    Current.insert({
      bike: i,
      lat: NaN,
      lng: NaN
    });
  }
}

if (BarChart.find().count() === 0) {
  console.log("Starting BarChart with math!");
  var randArray = [];
  _.times(7, function(){ randArray.push(_.random(10, 30)); });
  BarChart.insert({
    data: randArray
  });
}

if (AdminBarChart.find().count() === 0) {
  console.log("Starting AdminBarChart with math!");
  var randArray = [];
  _.times(12, function(){ randArray.push(_.random(40, 200)); });
  AdminBarChart.insert({
        name: '< 10 Minute Rides',
        data: randArray
        });
  var randArray = [];
  _.times(12, function(){ randArray.push(_.random(40, 200)); });
  AdminBarChart.insert({
        name: '10+ Minute Rides',
        data: randArray
      });
  var randArray = [];
  _.times(12, function(){ randArray.push(_.random(40, 200)); });
  AdminBarChart.insert({
        name: 'Off Campus Rides',
        data: randArray
    });
}

if (AdminAreaChart.find().count() === 0) {
  console.log("Starting AdminAreaChart with math!");
  AdminAreaChart.insert({
      name: 'Potentiometer Data',
      data: [50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50]
  });
}

Meteor.methods({
  'loop': function (dataSet, schema) {
    // Print out schema of received data]
    // for (var key in dataSet) {
    //   if (dataSet.hasOwnProperty(key)) {
    //     console.log(key + " -> " + dataSet[key]);
    //   }
    // }

    // Prepare fields to udpate MongoDB
    var fields = {};
    var root = ["Time." + dataSet.timeHH + '.' + dataSet.timemm];
    fields[root + ".user"] = dataSet.User;
    fields[root + ".lat"] = dataSet.Lat;
    fields[root + ".lng"] = dataSet.Long;

    // Update MongoDB data based on bike number
    var record = TimeSeries.findOne({Bike: dataSet.BikeNumber, YYYY: dataSet.timeYYYY, MM: dataSet.timeMM, DD: dataSet.timeDD});
    TimeSeries.update(
      record,
      { $set: fields }
    );

    return "ok";
  }
});

Meteor.methods({
  'current': function (dataSet, schema) {
    // Print out schema of received data]
    for (var key in dataSet) {
      if (dataSet.hasOwnProperty(key)) {
        console.log(key + " -> " + dataSet[key]);
      }
    }

    // Prepare fields to udpate MongoDB
    var fields = {};
    fields.lat = dataSet.lat;
    fields.lng = dataSet.lng;

    // Update MongoDB data based on bike number
    var record = Current.findOne({Bike: dataSet.BikeNumber});
    Current.update(
      record,
      { $set: fields }
    );

    return "ok";
  }
});

Meteor.methods({
  'chart': function (dataSet) {
    // Prepare fields to udpate MongoDB
    var fields = {};
    fields["data." + dataSet.BikeNumber] = dataSet.Potentiometer;
    fields.x = dataSet.x;
    console.log(dataSet.Potentiometer);

    // Update MongoDB data based on bike number
    var record = AdminAreaChart.findOne();
    AdminAreaChart.update(
      record,
      { $set: fields }
    );

    return "ok";
  }
});