TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST['board_show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.lists(), 'add', this.addListView);
    this.model.lists().each(this.addListView.bind(this))
  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addListView: function (list) {
    var subview = new TrelloClone.Views.List({ model: list });
    this.addSubview('.lists', subview);
  },

  removeListView: function (list) {
    this.removeModelSubview('.lists', list);
  }
});
