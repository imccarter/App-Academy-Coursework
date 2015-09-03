TrelloClone.Collections.Boards = Backbone.Collection.extend({

  model: TrelloClone.Models.Board,
  url: "/api/boards",

  getOrFetch: function (id) {
    var collection = this;
    var board = collection.get(id);
    if (!board) {
      board = new TrelloClone.Models.Board({ id: id });
      collection.add(board);
    }
    board.fetch();
    return board;
  }
});
