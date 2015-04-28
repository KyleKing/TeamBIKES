Router.configure({
  loadingTemplate: 'loading'
});

// Do these even work?
Router.plugin('dataNotFound', {dataNotFoundTemplate: 'notFound'});


/*********************************************/
/*   Public          */
/********************************************/
Router.route('/', {
  name: 'about',
});

Router.route('/FAQ', {
  layoutTemplate: 'appLayout'
});

Router.route('/map', {
  layoutTemplate: 'fullLayout'
});

/*********************************************/
/*   Make sure sign in only, but student role          */
/********************************************/
Router.route('/student', {
  layoutTemplate: 'appLayout'
});


/*********************************************/
/*   The Secuirty Barrier in between          */
/********************************************/
Router.plugin('ensureSignedIn', {
    // Array of pages only visible to users
    only: ['dashboard']
    // Array of pages not secured
    // except: ['about', 'FAQ', 'map', 'atSignIn', 'atSignUp', 'atForgotPassword', 'onePageScroll', 'skrollr', 'progress', 'home']
});


// Sign out and go to home page with route control
// Useful, from: http://stackoverflow.com/questions/27743660/proper-syntax-for-iron-routers-router-route
Router.route('/sign-out', function() { }, {
  name: 'signOut',
  onBeforeAction: function () {
    if (Meteor.userId()) { Meteor.logout(); }
    this.next();
  },
  onAfterAction: function () { Router.go('/'); }
});


// /*********************************************/
// /*   Private          */
// /********************************************/
// Router.route('/dashboard', {
//   controller: 'AppController'
// });

// Router.route('/users', {
// });

// Router.route('/charts', {
//   name: 'chartsAdmin',
//   controller: 'AppController'
// });

// Router.route('/RFIDlayout', {
//   controller: 'AppController'
// });

// Router.route('/mechanicView', {
//   controller: 'AppController'
// });

// Router.route('/mechmap', {
//   controller: 'MapController'
// });

// Router.route('/timeseries', {
//   controller: 'AppController'
// });

// Router.route('/admin2layoutAllData', {
//   controller: 'AppController',
//    waitOn: function () {
//      return Meteor.subscribe("TestUsersData");
//    },
//   data: function() {
// 	 return TestUsers.find({},{limit: 20});
//   }
// });

// Router.route('/admin2layoutBikeData/:_id', {
//   name: 'admin2layoutBikeData',
//   controller: 'AppController',
//   // // Note: this.params._id is shorthand for {_id: id}
//   waitOn: function () {
// 	return Meteor.subscribe("TestUsersData");
//   },
//   data: function() { return TestUsers.findOne(this.params._id); }
// });

// Router.route('/admin3layoutAllData', {
//   name: 'admin3layoutAllData',
//   controller: 'AppController',
//   waitOn: function () {
//     return Meteor.subscribe("TimeSeriesData");
//   },
//   data: function() {
// 	return TimeSeries.find({},{limit: 20});
//   }
// });

// Router.route('/admin3layoutBikeData/:_id', {
//   name: 'admin3layoutBikeData',
//   controller: 'AppController',
//   waitOn: function () {
// 	return Meteor.subscribe("TimeSeriesData");
//   },
//   data: function() { return TimeSeries.findOne(this.params._id); }
// });

// /*********************************************/
// /*   WIP - Test Routes          */
// /********************************************/

// Router.route('/progress', {
//   controller: 'AppController'
// });

// Router.route('/agency');


// /*********************************************/
// /*   Remove Below content for Production          */
// /********************************************/

// // For testing loading page with no wait time
// // Todo: Integrate more seamlessly into app
// Router.route('/loading');

// // Router.route('/items_0', {
// //   name: 'items',
// //   controller: 'AppController'
// // });