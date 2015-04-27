MapController = RouteController.extend({
  layoutTemplate: 'fullLayout',
  loadingTemplate: 'loading'
});

MapController.events({
  'click [data-action=logout]' : function() {
    AccountsTemplates.logout();
  }
});
