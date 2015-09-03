TrelloClone.Views.BoardsIndexItem = Backbone.View.extend({
  template: JST['boards_index_item'],
  tagName: 'li',
  className: 'boards',

  initialize: function () {
    this.listenTo(this.model, 'sync add', this.render);
  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    return this;
  }
});
