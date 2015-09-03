TrelloClone.Views.BoardsIndex = Backbone.CompositeView.extend({
  template: JST['boards_index'],

  events: {
    "submit .new-board-form": "newBoardHandler",
    "click .delete-board": "destroyBoard"
  },

  initialize: function () {
    this.listenTo(this.collection, 'add', this.addBoardView);
    this.listenTo(this.collection, 'remove', this.removeBoardView);
    this.listenTo(this.collection, 'sync remove', this.render);
    this.collection.each(this.addBoardView.bind(this));
  },

  destroyBoard: function (e) {
    var $target = $(e.currentTarget);
    var board = this.collection.get($target.attr('data-id'));
    board.destroy();
  },

  newBoardHandler: function (e) {
    e.preventDefault();
    var $form = $(e.currentTarget);
    var data = $form.serializeJSON();

    var newBoard = new TrelloClone.Models.Board();
    newBoard.save(data, {
      success: function () {
        this.collection.add(newBoard);
      }.bind(this)
    });
  },

  addBoardView: function (board) {
    console.log('addBoard');
    var subview = new TrelloClone.Views.BoardsIndexItem({ model: board });
    this.addSubview('.boards', subview);
  },

  render: function () {
    console.log('render');

    var content = this.template();
    this.$el.html(content);
    debugger;
    this.attachSubviews();
    return this;
  },

  removeBoardView: function (board) {
    this.removeModelSubview('.boards', board);
  }
});
