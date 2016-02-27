if Meteor.users.find({"email": "biker123456789@example.com"}).count() is 0
  # local variable with sample user profiles
  users = [
    {
      FullName: 'Normal Human'
      Email: "biker123456789@example.com"
      RFID: 'c5194f30'
      Roles: []
    }
    {
      FullName: 'Mechanic Wrench'
      Email: "mechanic@wrenchwrench.com"
      RFID: '653c4730'
      Roles: ['Mechanic', 'Employee']
    }
    {
      FullName: 'Redistribution Dude(ette)'
      Email: "redistribution@wrenchwrench.com"
      RFID: 'NA'
      Roles: ['Redistribution', 'Employee']
    }
    {
      FullName: 'Administrator BossMan'
      Email: "admin@theboss.com"
      RFID: 'NA'
      Roles: ['Admin']
    }
    {
      FullName: 'All Powerful Root'
      Email: 'root@example.com'
      RFID: 'NA'
      Roles: ['Root']
    }
  ]

  # Populate Accounts db
  _.each users, (user) ->
    id = Accounts.createUser(
      email: user.Email
      password: "password"
      profile:
        RFID: user.RFID
        name: user.FullName
      	UID: 111111111
    )
    if user.Roles.length > 0
      Roles.addUsersToRoles id, user.Roles
  console.log 'Created basic set of users with roles!'
