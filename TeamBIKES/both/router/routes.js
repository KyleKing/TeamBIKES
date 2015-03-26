Router.route('/', {
  name: 'home'
});

Router.route('/dashboard', {
  name: 'dashboard'
});

Router.plugin('ensureSignedIn', {
    // // Array of pages only visible to users
    only: ['dashboard']
    // except: ['home', 'atSignIn', 'atSignUp', 'atForgotPassword']
});
