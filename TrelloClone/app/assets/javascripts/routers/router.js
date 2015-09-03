TrelloClone.Routers.Router = Backbone.Router.extend({
  routes: {
    '': 'boardsIndex',
    'boards/:id': 'boardShow'
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this._collection = options.boards;
  },

  boardsIndex: function () {
    var boards = this._collection;
    var indexView = new TrelloClone.Views.BoardsIndex({collection: boards});
    var that = this;
    boards.fetch();
    this.swap(indexView);
  },

  boardShow: function (id) {
    var board = this._collection.getOrFetch(id);
    var showView = new TrelloClone.Views.BoardShow({
      model: board,
    });
    this.swap(showView);
  },

  swap: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    $('#content').append(view.$el);
    view.render();
  }
});
