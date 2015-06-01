// See UserAccounts Package for configuration options
AccountsTemplates.configureRoute('signIn', {
  layoutTemplate: 'appLayout',
  redirect: '/student'
});
AccountsTemplates.configureRoute('signUp', {
  layoutTemplate: 'appLayout',
  redirect: '/student'
});
AccountsTemplates.configureRoute('forgotPwd', {layoutTemplate: 'appLayout'});
AccountsTemplates.configureRoute('changePwd', {layoutTemplate: 'appLayout'});
AccountsTemplates.configureRoute('ensureSignedIn', {layoutTemplate: 'appLayout'});

// mySubmitFunc
function mySubmitFunc(error, state) {
  // console.log('mySubmitFunc called with:');
  // console.log(['error: ', error]);
  // console.log(['state: ', state]); // 'signUp' or 'signIn'
  if (Meteor.userId() !== undefined & state === 'signUp') {
    value = Meteor.call('mySubmitFunc', Meteor.userId());
    console.log('Set RFID code');
  }
}

// <personalization>
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
// </personalization>

AccountsTemplates.addField({
  _id: 'name',
  type: 'text',
  placeholder: {
      signUp: "First Last"
  },
  required: true,
});

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

// AccountsTemplates.addField({
//     _id: "gender",
//     type: "select",
//     displayName: "Gender",
//     select: [
//         {
//             text: "Male",
//             value: "male",
//         },
//         {
//             text: "Female",
//             value: "female",
//         },
//     ],
// });

// AccountsTemplates.addField({
//     _id: "snack",
//     type: "radio",
//     displayName: "Preferred Snack",
//     select: [
//         {
//         text: "Apple",
//         value: "aa",
//       }, {
//         text: "Banana",
//         value: "bb",
//       }, {
//         text: "Nutella",
//         value: "nn",
//       },
//     ],
// });

// AccountsTemplates.addField({
//     _id: "handlebars",
//     type: "checkbox",
//     // displayName: "Subscribe me to mailing List",
//     displayName: "I ride my bike with no handlebars",
// });

// AccountsTemplates.addField({
//     _id: 'RFIDtemp',
//     type: 'hidden'
// });

// ?RFIDtemp=xkgj