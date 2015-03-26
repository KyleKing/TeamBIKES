Router.route('/', {
  name: 'home'
});

Router.route('/dashboard', {
  name: 'dashboard'
});

Router.route('/users', {
  name: 'users'
});

Router.plugin('ensureSignedIn', {
    // // Array of pages only visible to users
    only: ['dashboard']
    // except: ['home', 'atSignIn', 'atSignUp', 'atForgotPassword']
});


/*********************************************/
/*   Remove Below content for Production          */
/********************************************/

// For testing loading page with no wait time
// Todo: Integrate more seamlessly into app
Router.route('/loading', {
  name: 'loading'
});