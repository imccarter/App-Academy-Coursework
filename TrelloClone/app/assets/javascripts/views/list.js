TrelloClone.Views.List = Backbone.View.extend({
  template: JST['list'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function ()  {
    var content = this.template({list: this.model});
    this.$el.html(content);
    return this;
  }
});
