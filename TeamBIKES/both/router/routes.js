// Public
Router.route('/', {
  name: 'about',
  controller: 'AppController'
});

Router.route('FAQ', {
  path: '/FAQ',
  controller: 'AppController'
});

Router.route('map', {
  path: '/map',
  controller: 'MapController'
});

//
// The Secuirty Barrier in between
//
Router.plugin('ensureSignedIn', {
    // // Array of pages only visible to users
    // only: ['dashboard']
    // Array of pages not secured
    except: ['about', 'FAQ', 'map']
});

// Private
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


/*********************************************/
/*   Remove Below content for Production          */
/********************************************/

// For testing loading page with no wait time
// Todo: Integrate more seamlessly into app
Router.route('/loading', {
  name: 'loading'
});