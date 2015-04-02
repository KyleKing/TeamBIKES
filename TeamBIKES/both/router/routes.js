Router.route('/', {
  name: 'home'
});

Router.route('/dashboard', {
  name: 'dashboard'
});

Router.route('/users', {
  name: 'users'
});

Router.route('FAQ', {
  path: '/FAQ',
  controller: 'AppController'
});

Router.plugin('ensureSignedIn', {
    // // Array of pages only visible to users
    // only: ['dashboard']
    // Array of pages not secured
    except: ['home', 'FAQ']
});


/*********************************************/
/*   Remove Below content for Production          */
/********************************************/

// For testing loading page with no wait time
// Todo: Integrate more seamlessly into app
Router.route('/loading', {
  name: 'loading'
});