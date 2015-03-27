/*********************************************/
/*   Remove Below content for Production          */
/********************************************/

  // Login Demo - Publish login information for test purposes
  Meteor.publish("usersInfo", function() {
    return Meteor.users.find();
  });