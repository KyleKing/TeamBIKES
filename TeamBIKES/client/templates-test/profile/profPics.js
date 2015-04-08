Template.profPics.helpers({
  photo: function () {
    return Session.get("photo");
  }
});

Template.profPics.events({
  'click button': function () {
    var cameraOptions = {
      width: 800,
      height: 600
    };

    MeteorCamera.getPicture(cameraOptions, function (error, data) {
      Session.set("photo", data);
    });
  }
});