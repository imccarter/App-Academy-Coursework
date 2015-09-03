window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function() {
    // alert('Hello from Backbone!');
    new TrelloClone.Routers.Router({
      $rootEl: $("#content"),
      boards: new TrelloClone.Collections.Boards()
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  TrelloClone.initialize();
});
