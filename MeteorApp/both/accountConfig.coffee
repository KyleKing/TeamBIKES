# The complete guide:
# https://github.com/meteor-useraccounts/core/blob/master/Guide.md
# The flow router specific version:
# https://atmospherejs.com/useraccounts/flow-routing

myLogoutFunc = ->
  FlowRouter.go '/'

mySubmitFunc = (error, state) ->
  # Randomly create an RFID code
  if (Meteor.userId() isnt undefined & state is 'signUp')
    Meteor.call( 'completeAccountRecord', Meteor.userId(), 'signUp' )

# Accounts Personalization
AccountsTemplates.configure
  # Behavior
  confirmPassword: true
  enablePasswordChange: true
  forbidClientAccountCreation: false
  overrideLoginErrors: true
  sendVerificationEmail: true
  lowercaseUsername: false
  focusFirstInput: true

  # Appearance
  showAddRemoveServices: false
  showForgotPasswordLink: true
  showLabels: true
  showPlaceholders: true
  showResendVerificationEmailLink: true

  # Client-side Validation
  continuousValidation: true
  negativeFeedback: false
  negativeValidation: true
  positiveValidation: true
  positiveFeedback: true
  showValidating: true

  # Privacy Policy and Terms of Use
  privacyUrl: 'privacy'
  termsUrl: 'terms-of-use'

  # Redirects
  homeRoutePath: '/'
  redirectTimeout: 4000

  # Hooks
  onLogoutHook: myLogoutFunc
  onSubmitHook: mySubmitFunc
  # preSignUpHook: myPreSubmitFunc
  # postSignUpHook: myPostSubmitFunc

  # Texts
  texts:
    button: signUp: 'Register Now!'
    socialSignUp: 'Register'
    socialIcons: 'meteor-developer': 'fa fa-rocket'
    title:
      changePwd: 'Change Password'
      resetPwd: 'Reset Password'
      forgotPwd: 'Recover Your Password'
      signIn: 'Login to reserve a bike or check on you account'
      signUp: 'Join an Exclusive Community of RedBar Bikers'

# Name Field
AccountsTemplates.addField
  _id: 'name'
  placeholder: signUp: 'First Last'
  re: /\W{1,3}/
  required: true
  type: 'text'
# UID
AccountsTemplates.addField
  _id: 'UID'
  errStr: '1 digits'
  maxLength: 9
  minLength: 9
  placeholder: signUp: 'UID'
  re: /(?=.*\d).{1,}/
  required: true
  type: 'text'

AccountsTemplates.configure
  defaultLayout: 'layout'
  defaultTemplate: 'loginForm'
  defaultLayoutRegions: {}
  defaultContentRegion: 'full'

AccountsTemplates.configureRoute 'signIn'
AccountsTemplates.configureRoute 'signUp'
AccountsTemplates.configureRoute 'forgotPwd'
AccountsTemplates.configureRoute 'resetPwd'
AccountsTemplates.configureRoute 'changePwd'
