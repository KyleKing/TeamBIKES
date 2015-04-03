// snapsvgdraw is a template with nothing in it. this draws a 800 x 600 canvas for drawing.
Template.snapsvgdraw.rendered = function () {
  "use strict";
  Meteor.setTimeout(function () {var s = new Snap(800, 600), bigCircle = s.circle(150, 150, 100); }, 1000);
};