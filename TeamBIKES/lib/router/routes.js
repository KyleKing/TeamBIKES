/*********************************************/
/*   Public          */
/********************************************/
Router.route('/', {
  name: 'about',
  controller: 'MapController'
});

Router.route('/FAQ', {
  controller: 'AppController'
});

Router.route('/map', {
  controller: 'MapController'
});

/*********************************************/
/*   Make sure sign in only, but student role          */
/********************************************/
Router.route('/student', {
  controller: 'AppController'
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


/*********************************************/
/*   Private          */
/********************************************/
Router.route('/dashboard', {
});

Router.route('/users', {
});

Router.route('/charts', {
  name: 'chartsAdmin',
  controller: 'AppController'
});

Router.route('/Admin3', {
  name: 'admin3layout',
  controller: 'AppController'
});

Router.route('/RFIDlayout', {
  controller: 'AppController'
});

Router.route('/mechanicView', {
  controller: 'AppController'
});

Router.route('/mechmap', {
  controller: 'MapController'
});

Router.route('/timeseries', {
  controller: 'AppController'
});

Router.route('/admin2layoutAllData', {
  controller: 'AppController',
  // waitOn: function () {
  //   return Meteor.subscribe("TestUsersData");
  // },
  data: function() {
    return TestUsers.find({},{limit: 20});
  }
});

Router.route('/admin2layoutBikeData/:_id', {
  name: 'admin2layoutBikeData',
  controller: 'AppController',
  // // Note: this.params._id is shorthand for {_id: id}
  data: function() { return TestUsers.findOne(this.params._id); }
});

/*********************************************/
/*   WIP - Test Routes          */
/********************************************/

Router.route('/home', {
  controller: 'skrollrController'
});

Router.route('/onePageScroll', {
  controller: 'MapController'
});

Router.route('/skrollr', {
  controller: 'AppController'
});

Router.route('/progress', {
  controller: 'AppController'
});


/*********************************************/
/*   Remove Below content for Production          */
/********************************************/

// For testing loading page with no wait time
// Todo: Integrate more seamlessly into app
Router.route('/loading');

// Router.route('/items_0', {
//   name: 'items',
//   controller: 'AppController'
// });