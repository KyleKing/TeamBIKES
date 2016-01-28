# The complete guide:
# https://github.com/meteor-useraccounts/core/blob/master/Guide.md
# The flow router specific version:
# https://atmospherejs.com/useraccounts/flow-routing

myPostLogout = ->
  #example redirect after logout
  FlowRouter.go '/'

AccountsTemplates.configure
    defaultLayout: 'layout'
    defaultTemplate: 'login_form'
    defaultLayoutRegions: {}
    defaultContentRegion: 'Full'

AccountsTemplates.configureRoute 'signIn'
AccountsTemplates.configureRoute 'signUp'
# AccountsTemplates.configureRoute 'forgotPwd'
# AccountsTemplates.configureRoute 'changePwd'


# Core routes for accounts
# See UserAccounts Package for configuration options
# mySubmitFunc - Randomly creates an RFID code

mySubmitFunc = (error, state) ->
  if (Meteor.userId() isnt undefined & state is 'signUp')
    # value = Meteor.call('mySubmitFunc', Meteor.userId())
    console.log('Set RFID code')
  return

# AccountsTemplates.configureRoute 'signIn',
#   redirect: '/'
# AccountsTemplates.configureRoute 'signUp',
#   redirect: '/'
# AccountsTemplates.configureRoute 'forgotPwd'
# AccountsTemplates.configureRoute 'changePwd'
# AccountsTemplates.configureRoute 'ensureSignedIn'

# Accounts Personalization
AccountsTemplates.configure
  confirmPassword: false
  enablePasswordChange: true
  forbidClientAccountCreation: false
  overrideLoginErrors: true
  sendVerificationEmail: false
  lowercaseUsername: false
  showAddRemoveServices: false
  showForgotPasswordLink: true
  showLabels: true
  showPlaceholders: true
  continuousValidation: false
  negativeFeedback: false
  negativeValidation: true
  positiveValidation: true
  positiveFeedback: true
  showValidating: true
  privacyUrl: 'privacy'
  termsUrl: 'terms-of-use'
  homeRoutePath: '/'
  redirectTimeout: 3000
  onSubmitHook: mySubmitFunc
  texts: title:
    changePwd: 'Change Password'
    enrollAccount: 'FIXME: Enroll Title text'
    forgotPwd: 'Recover Your Password'
    resetPwd: 'Reset Password'
    signIn: 'Login to reserve a bike or check on you account'
    signUp: 'Join an Exclusive Community of RedBar Bikers'
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
# Name Field
AccountsTemplates.addField
  _id: 'name'
  placeholder: signUp: 'First Last'
  re: /\W{1,3}/
  required: true
  type: 'text'