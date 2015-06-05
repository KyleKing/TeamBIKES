// Global Route Configuration
Router.configure({
  loadingTemplate: 'loading',
  notFoundTemplate: 'notFound',
  layoutTemplate: 'appLayout'
});

// Plugins
Router.plugin('dataNotFound', {dataNotFoundTemplate: 'notFound'});
Router.plugin('ensureSignedIn', {
  except: ['about', 'atSignIn', 'atSignUp', 'atForgotPassword', 'progress']
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

/*   Public */
Router.route('/', {
  name: 'about'
});

/* User */
Router.route('/student');
Router.route('/map', {
  layoutTemplate: 'fullLayout'
});

/* Administrator */
Router.route('/dashboard');
Router.route('/users');

Router.route('/charts', {
  name: 'chartsAdmin'
});

Router.route('/RFIDlayout');
Router.route('/mechanicView');
Router.route('/mechmap');
Router.route('/timeseries');

Router.route('/admin2layoutAllData', {
  waitOn: function () {
   return Meteor.subscribe("TestUsersData");
  },
  data: function() {
	 return TestUsers.find({},{limit: 20});
  }
});

Router.route('/admin2layoutBikeData/:_id', {
  name: 'admin2layoutBikeData',
  // // Note: this.params._id is shorthand for {_id: id}
  waitOn: function () {
	return Meteor.subscribe("TestUsersData");
  },
  data: function() { return TestUsers.findOne(this.params._id); }
});

Router.route('/admin3layoutAllData', {
  name: 'admin3layoutAllData',
  waitOn: function () {
    return Meteor.subscribe("TimeSeriesData");
  },
  data: function() {
	return TimeSeries.find({},{limit: 20});
  }
});

Router.route('/admin3layoutBikeData/:_id', {
  name: 'admin3layoutBikeData',
  waitOn: function () {
	return Meteor.subscribe("TimeSeriesData");
  },
  data: function() { return TimeSeries.findOne(this.params._id); }
});

/*********************************************/
/*   WIP - Test Routes                       */
/********************************************/
Router.route('/progress');
Router.route('/agency');

// /*********************************************/
// /*   Remove Below content for Production     */
// /********************************************/
// // For testing loading page with no wait time
// // Todo: Integrate more seamlessly into app
// Router.route('/loading');