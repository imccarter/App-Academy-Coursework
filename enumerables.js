Array.prototype.myEach = function (callback) {
  for (var i = 0; i < this.length; i++) {
    callback(this[i]);
  }
  return this;
};

Array.prototype.myMap = function (callback) {
  var newArray = [];
  for (var i = 0; i < this.length; i++) {
    newArray.push(callback(this[i]));
  }
  return newArray;
};

Array.prototype.myMap2 = function (callback) {
  var newArray = [];

  this.myEach(function (el) {
    newArray.push(callback(el));
  });
  return newArray;
};

Array.prototype.myInject = function (callback) {
  var accum = this[0];
  this.slice(1).myEach(function (el) {
    accum = callback(accum, el);
  });
  return accum;
};
