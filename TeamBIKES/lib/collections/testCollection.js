
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