/*********************************************/
/*   Public          */
/********************************************/
Router.route('/', {
  name: 'about',
  controller: 'MapController'
});

Router.route('FAQ', {
  path: '/FAQ',
  controller: 'AppController'
});

Router.route('map', {
  path: '/map',
  controller: 'MapController'
});

/*********************************************/
/*   Make sure sign in only, but student role          */
/********************************************/
Router.route('student', {
  path: '/student',
  controller: 'AppController'
});


//
// The Secuirty Barrier in between
//
Router.plugin('ensureSignedIn', {
    // // Array of pages only visible to users
    // only: ['dashboard']
    // Array of pages not secured
    except: ['about', 'FAQ', 'map', 'atSignIn', 'atSignUp', 'atForgotPassword', 'onePageScroll', 'skrollr', 'progress', 'home']
});


/*********************************************/
/*   Private          */
/********************************************/
Router.route('/dashboard', {
  name: 'dashboard'
});

Router.route('/users', {
  name: 'users'
});

Router.route('chartsAdmin', {
  path: '/charts',
  controller: 'AppController'
});

Router.route('admin3layout', {
  path: '/Admin3',
  controller: 'AppController'
});

Router.route('RFIDlayout', {
  path: '/RFIDlayout',
  controller: 'AppController'
});

Router.route('mechanicView', {
  path: '/mechanicView',
  controller: 'AppController'
});

Router.route('mechmap', {
  path: '/mechmap',
  controller: 'MapController'
});

Router.route('timeseries', {
  path: '/timeseries',
  controller: 'AppController'
});

/*********************************************/
/*   WIP - Test Routes          */
/********************************************/

Router.route('/home', {
  name: 'home',
  controller: 'skrollrController'
});

Router.route('/onePageScroll', {
  name: 'onePageScroll',
  controller: 'MapController'
});

Router.route('/skrollr', {
  name: 'skrollr',
  controller: 'AppController'
});

Router.route('/progress', {
  name: 'progress',
  controller: 'AppController'
});

// Router.route('admin2layout', {
//   path: '/Admin2',
//   controller: 'AppController'
// });

Router.route('/admin2layout/:_id', {
  name: 'admin2layout',
  controller: 'PostController'
});

PostController = AppController.extend({
  action: function () {
    // set the reactive state variable "postId" with a value
    // of the id from our url
    this.state.set('postId', this.params._id);
    this.render();
  }
});

/*********************************************/
/*   Remove Below content for Production          */
/********************************************/

// For testing loading page with no wait time
// Todo: Integrate more seamlessly into app
Router.route('/loading', {
  name: 'loading'
});