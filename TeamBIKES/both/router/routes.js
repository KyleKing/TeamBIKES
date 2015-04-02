// Public
Router.route('/', {
  name: 'about',
  controller: 'AppController'
});

Router.route('FAQ', {
  path: '/FAQ',
  controller: 'AppController'
});

//
// The Secuirty Barrier in between
//
Router.plugin('ensureSignedIn', {
    // // Array of pages only visible to users
    // only: ['dashboard']
    // Array of pages not secured
    except: ['about', 'FAQ']
});

// Private
Router.route('/dashboard', {
  name: 'dashboard'
});

Router.route('/users', {
  name: 'users'
});


/*********************************************/
/*   Remove Below content for Production          */
/********************************************/

// For testing loading page with no wait time
// Todo: Integrate more seamlessly into app
Router.route('/loading', {
  name: 'loading'
});