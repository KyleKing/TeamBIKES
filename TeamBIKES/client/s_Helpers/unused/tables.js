// Copied from: https://groups.google.com/forum/#!topic/meteor-talk/XSX1wgeZ06U
var currentIndex = 0;
Template.registerHelper('listIndex', function(){
  return currentIndex += 1;
});