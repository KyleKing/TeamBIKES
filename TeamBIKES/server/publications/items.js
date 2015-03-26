/*********************************************/
/*   Part of Boilerplate: Items collection          */
/********************************************/

Meteor.publishComposite("items", function() {
  return {
    find: function() {
      return Items.find({});
    }
    // ,
    // children: [
    //   {
    //     find: function(item) {
    //       return [];
    //     }
    //   }
    // ]
  };
});

/*********************************************/
/*   Remove Below content for Production          */
/********************************************/

  // Login Demo - Publish login information for test purposes
  Meteor.publish("usersInfo", function() {
    return Meteor.users.find();
  });