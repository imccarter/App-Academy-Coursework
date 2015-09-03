Backbone.CompositeView = Backbone.View.extend({

  subviews: function (selector) {
    this._subviews = this._subviews || {};
    if (selector) {
      this._subviews[selector] = this._subviews[selector] || [];
      return this._subviews[selector];
    } else {
      return this._subviews;
    }
  },

  addSubview: function (selector, view) {
    this.subviews(selector).push(view);
    this.attachSubview(selector, view.render());
  },

  attachSubview: function (selector, subview) {
    this.$(selector).append(subview.$el);
    subview.delegateEvents();

    if (subview.attachSubviews) {
      subview.attachSubviews();
    }
  },

  attachSubviews: function () {
    var view = this;
    _(this.subviews()).each(function (selectorSubviews, selector) {
      view.$(selector).empty();
      _(selectorSubviews).each(function (subview) {
        view.attachSubview(selector, subview);
      });
    });
  },

  removeSubview: function (selector, subview) {
    subview.remove();

    var subviews = this.subviews(selector);
    subviews.splice(subviews.indexOf(subview), 1);
  },

  remove: function () {
    Backbone.View.prototype.remove.call(this);
    _(this.subviews()).each(function (subviews) {
      _(subviews).each(function (subview) {
        subview.remove();
      });
    });
  },

  removeModelSubview: function (selector, model) {
    var selectorSubviews = this.subviews(selector);
    var i = selectorSubviews.findIndex(function (subview) {
      return subview.model === model;
    });
    if (i === -1) { return; }
    selectorSubviews[i].remove();
    selectorSubviews.splice(i, 1);
  },



});

  // Fix better!
Array.prototype.findIndex = function(callback) {
  for(var i = 0; i < this.length; i++) {
    if (callback(this[i])) { return i; }
  }

  return -1;
};
