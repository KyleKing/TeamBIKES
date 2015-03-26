// See UserAccounts Package for configuration options
AccountsTemplates.configureRoute('signIn', {layoutTemplate: 'appLayout'});
AccountsTemplates.configureRoute('signUp', {layoutTemplate: 'appLayout'});
AccountsTemplates.configureRoute('forgotPwd', {layoutTemplate: 'appLayout'});
AccountsTemplates.configureRoute('changePwd', {layoutTemplate: 'appLayout'});
AccountsTemplates.configureRoute('ensureSignedIn', {layoutTemplate: 'appLayout'});

// mySubmitFunc
function mySubmitFunc(error, state) {
  // console.log('mySubmitFunc called with:');
  // console.log(['error: ', error]);
  // console.log(['state: ', state]);
  if (Meteor.userId()) {
    value = Meteor.call('mySubmitFunc', Meteor.userId());
    console.log('Set RFID code');
  }
}

AccountsTemplates.configure({
  // Behaviour
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
  redirectTimeout: 4000,

  // // Need to create function:
  // // Hooks
  // onLogoutHook: myLogoutFunc,
  onSubmitHook: mySubmitFunc,

  // Texts
  texts: {
    title: {
      changePwd: "Password Title text",
      enrollAccount: "Enroll Title text",
      forgotPwd: "Recover Your Password",
      resetPwd: "Reset Password",
      signIn: "Sign In",
      signUp: "Sign Up",
      // verifyEmail: "Verify Email Title text",
    },
    navSignIn: "signIn text",
    navSignOut: "signOut text",
    optionalField: "optional text",
    pwdLink_pre: " ",
    pwdLink_link: "Forgot your password?",
    pwdLink_suff: " ",
    sep: "OR text",
    signInLink_pre: "If you already have an account",
    signInLink_link: "Sign In",
    signInLink_suff: " ",
    signUpLink_pre: "Dont have an account?",
    signUpLink_link: "Register",
    signUpLink_suff: " ",
    // socialAdd: "add text",
    // socialConfigure: "configure text",
    // socialIcons: {
    //     "meteor-developer": "fa fa-rocket text",
    // },
    // socialRemove: "remove text",
    // socialSignIn: "signIn text",
    // socialSignUp: "signUp text",
    // socialWith: "with text",
    termsPreamble: "By clicking sign up, you agree to our ",
    termsPrivacy: "Privacy Policy",
    termsAnd: "and",
    termsTerms: "Terms and Conditions",
    button: {
      changePwd: "Password Text text",
      enrollAccount: "Enroll Text text",
      forgotPwd: "Reset Password",
      resetPwd: "Reset Pwd Text text",
      signIn: "Sign In",
      signUp: "Sign Up!",
    },
    // info: {
    //     emailSent: "info.emailSent text",
    //     emailVerified: "info.emailVerified text",
    //     pwdChanged: "info.passwordChanged text",
    //     pwdReset: "info.passwordReset text",
    //     pwdSet: "info.passwordReset text",
    //     signUpVerifyEmail: "Registration Successful! Please check your email and follow the instructions. text",
    // },
    inputIcons: {
        isValidating: "fa fa-spinner fa-spin text",
        hasSuccess: "fa fa-check text",
        hasError: "fa fa-times text",
    },
    errors: {
      // loginForbidden: "error.accounts.Login forbidden text",
      mustBeLoggedIn: "You must log in to access this page",
      pwdMismatch: "Error: Passwords Dont Match",
    }
  }
});

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
  minLength: 9,
  re: /(?=.*\d).{9,}/,
  errStr: '9 digits',
});

AccountsTemplates.addField({
    _id: "gender",
    type: "select",
    displayName: "Gender",
    select: [
        {
            text: "Male",
            value: "male",
        },
        {
            text: "Female",
            value: "female",
        },
    ],
});

AccountsTemplates.addField({
    _id: "snack",
    type: "radio",
    displayName: "Preferred Snack",
    select: [
        {
        text: "Apple",
        value: "aa",
      }, {
        text: "Banana",
        value: "bb",
      }, {
        text: "Nutella",
        value: "nn",
      },
    ],
});

AccountsTemplates.addField({
    _id: "handlebars",
    type: "checkbox",
    // displayName: "Subscribe me to mailing List",
    displayName: "I ride my bike with no handlebars",
});

// AccountsTemplates.addField({
//     _id: 'RFIDtemp',
//     type: 'hidden'
// });

// ?RFIDtemp=xkgj