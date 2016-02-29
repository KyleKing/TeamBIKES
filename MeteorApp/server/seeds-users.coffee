Meteor.methods 'Create_Users': ->
  # local variable with sample user profiles
  users = [
    {
      FullName: 'Normal Human'
      Email: "biker123456789@example.com"
      RFID: 'c5194f30'
      Roles: ['User']
      UID: 111111111
    }
    {
      FullName: 'Mechanic Wrench'
      Email: "mechanic@wrenchwrench.com"
      RFID: '653c4730'
      Roles: ['Mechanic', 'Employee']
      UID: 111111111
    }
    {
      FullName: 'Redistribution Dude(ette)'
      Email: "redistribution@wrenchwrench.com"
      RFID: 'NA'
      Roles: ['Redistribution', 'Employee']
      UID: 111111112
    }

    {
      FullName: 'Administrator BossMan'
      Email: "admin@theboss.com"
      RFID: 'NA'
      Roles: ['Admin']
      UID: 111111113
    }
    {
      FullName: 'All Powerful Root'
      Email: 'root@example.com'
      RFID: 'NA'
      Roles: ['Root']
      UID: 111111114
    }
  ]

  # Populate Accounts db
  _.each users, (user) ->
    if Meteor.users.find({'profile.name': user.FullName}).count() is 0
      id = Accounts.createUser(
        username: user.Email
        emails: [
          address: user.Email
          verified: false
        ]
        password: "password"
        profile:
          RFID: user.RFID
          name: user.FullName
          UID: user.UID
      )
      if user.Roles.length > 0
        Roles.addUsersToRoles id, user.Roles

  console.log 'Create_Users: Basic set of users with roles'.yellow
