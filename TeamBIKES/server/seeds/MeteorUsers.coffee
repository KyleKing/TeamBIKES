# Create staff roles (for more info see roles package)
if Meteor.users.find({}).count() == 0
  # local variable with sample user profiles
  users = [
    {
      FullName: 'Kyle'
      Email: 'normal@example.com'
      Roles: []
    }
    {
      FullName: 'Mechanic'
      Email: 'mechanic@example.com'
      Roles: ['Mechanic']
    }
    {
      FullName: 'Redistribution'
      Email: 'redistribution@example.com'
      Roles: ['Redistribution']
    }
    {
      FullName: 'Num1Employee'
      Email: 'Num1Employee@example.com'
      Roles: ['Mechanic', 'Redistribution']
    }
    {
      FullName: 'Admin'
      Email: 'admin@example.com'
      Roles: ['Admin']
    }
    {
      FullName: 'Root'
      Email: 'root@example.com'
      Roles: ['Root']
    }
  ]

  # Populate Accounts db
  _.each users, (user) ->
    id = undefined
    id = Accounts.createUser(
      email: user.Email
      password: 'password'
      profile: name: user.FullName)
    if user.Roles.length > 0
      # Need _id of existing user record so this call must come
      # after `Accounts.createUser` or `Accounts.onCreate`
      Roles.addUsersToRoles id, user.Roles
    return