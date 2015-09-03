TrelloClone.Collections.Lists = Backbone.Collection.extend({

  model: TrelloClone.Models.List,
  url: "/api/lists",

  comparator: function (list) {
    return list.get('ord');
  },

  getOrFetch: function (id) {
    var collection = this;
    var list = collection.get(id);
    if (!list) {
      list = new TrelloClone.Collections.Lists({ id: id });
      collection.add(list);
    }
    list.fetch();
    return list;
  }
});
