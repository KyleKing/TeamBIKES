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


# # Core routes for accounts
# # See UserAccounts Package for configuration options
# # mySubmitFunc - Randomly creates an RFID code

# mySubmitFunc = (error, state) ->
#   # if (Meteor.userId() !== undefined & state === 'signUp') {
#   #   value = Meteor.call('mySubmitFunc', Meteor.userId());
#   #   console.log('Set RFID code');
#   # }
#   return

# AccountsTemplates.configureRoute 'signIn',
#   redirect: '/'
# AccountsTemplates.configureRoute 'signUp',
#   redirect: '/'
# AccountsTemplates.configureRoute 'forgotPwd'
# AccountsTemplates.configureRoute 'changePwd'
# AccountsTemplates.configureRoute 'ensureSignedIn'

# # Accounts Personalization
# AccountsTemplates.configure
#   confirmPassword: false
#   enablePasswordChange: true
#   forbidClientAccountCreation: false
#   overrideLoginErrors: true
#   sendVerificationEmail: false
#   lowercaseUsername: false
#   showAddRemoveServices: false
#   showForgotPasswordLink: true
#   showLabels: true
#   showPlaceholders: true
#   continuousValidation: false
#   negativeFeedback: false
#   negativeValidation: true
#   positiveValidation: true
#   positiveFeedback: true
#   showValidating: true
#   privacyUrl: 'privacy'
#   termsUrl: 'terms-of-use'
#   homeRoutePath: '/'
#   redirectTimeout: 3000
#   onSubmitHook: mySubmitFunc
#   texts: title:
#     changePwd: 'Change Password'
#     enrollAccount: 'Enroll Title text'
#     forgotPwd: 'Recover Your Password'
#     resetPwd: 'Reset Password'
#     signIn: 'Sign In'
#     signUp: 'Sign Up'
# # # Name Field
# # AccountsTemplates.addField
# #   _id: 'name'
# #   type: 'text'
# #   placeholder: signUp: 'First Last'
# #   required: true
# # # UID
# # AccountsTemplates.addField
# #   _id: 'UID'
# #   type: 'text'
# #   placeholder: signUp: 'UID'
# #   required: true
# #   minLength: 1
# #   re: /(?=.*\d).{1,}/
# #   errStr: '1 digits'