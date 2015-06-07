# Create staff roles (for more info see roles package)
if Meteor.users.find({}).count() == 0
  # local variable with sample user profiles
  users = [
    {
      name: 'Kyle King'
      email: 'normal@example.com'
      roles: []
    }
    {
      name: 'Mechanic'
      email: 'mechanic@example.com'
      roles: ['Mechanic']
    }
    {
      name: 'Redistribution'
      email: 'redistribution@example.com'
      roles: ['Redistribution']
    }
    {
      name: 'Num1Employee'
      email: 'Num1Employee@example.com'
      roles: ['Mechanic', 'Redistribution']
    }
    {
      name: 'Admin'
      email: 'admin@example.com'
      roles: ['Admin']
    }
    {
      name: 'Root'
      email: 'root@example.com'
      roles: ['Root']
    }
  ]
  # Populate Accounts db
  _.each users, (user) ->
    id = undefined
    id = Accounts.createUser(
      email: user.email
      password: 'password'
      profile: name: user.name)
    if user.roles.length > 0
      # Need _id of existing user record so this call must come
      # after `Accounts.createUser` or `Accounts.onCreate`
      Roles.addUsersToRoles id, user.roles
    return