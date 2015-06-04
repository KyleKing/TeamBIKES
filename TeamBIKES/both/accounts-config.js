// Core routes for accounts
// See UserAccounts Package for configuration options
AccountsTemplates.configureRoute('signIn', { layoutTemplate: 'appLayout', redirect: '/student' });
AccountsTemplates.configureRoute('signUp', { layoutTemplate: 'appLayout', redirect: '/student' });
AccountsTemplates.configureRoute('forgotPwd', {layoutTemplate: 'appLayout'});
AccountsTemplates.configureRoute('changePwd', {layoutTemplate: 'appLayout'});
AccountsTemplates.configureRoute('ensureSignedIn', {layoutTemplate: 'appLayout'});

// mySubmitFunc - Randomly creates an RFID code
function mySubmitFunc(error, state) {
  // if (Meteor.userId() !== undefined & state === 'signUp') {
  //   value = Meteor.call('mySubmitFunc', Meteor.userId());
  //   console.log('Set RFID code');
  // }
}

// Accounts Personalization
AccountsTemplates.configure({
  // Behavior
  confirmPassword: false,
  enablePasswordChange: true,
  forbidClientAccountCreation: false,
  overrideLoginErrors: true,
  sendVerificationEmail: false,
  lowercaseUsername: false,

  // Appearance
  showAddRemoveServices: false,
  showForgotPasswordLink: true,
  showLabels: true,
  showPlaceholders: true,

  // Client-side Validation
  continuousValidation: false,
  negativeFeedback: false,
  negativeValidation: true,
  positiveValidation: true,
  positiveFeedback: true,
  showValidating: true,

  // Privacy Policy and Terms of Use
  privacyUrl: 'privacy',
  termsUrl: 'terms-of-use',

  // Redirects
  homeRoutePath: '/',
  redirectTimeout: 3000,

  // Hooke
  // onLogoutHook: myLogoutFunc,
  onSubmitHook: mySubmitFunc,

  // Texts
  texts: {
    title: {
      changePwd: "Change Password",
      enrollAccount: "Enroll Title text",
      forgotPwd: "Recover Your Password",
      resetPwd: "Reset Password",
      signIn: "Sign In",
      signUp: "Sign Up",
    },
  }
});

// Name Field
AccountsTemplates.addField({
  _id: 'name',
  type: 'text',
  placeholder: {
      signUp: "First Last"
  },
  required: true,
});
// UID
AccountsTemplates.addField({
  _id: 'UID',
  type: 'text',
  placeholder: {
      signUp: "UID"
  },
  required: true,
  minLength: 1,
  re: /(?=.*\d).{1,}/,
  errStr: '1 digits',
});