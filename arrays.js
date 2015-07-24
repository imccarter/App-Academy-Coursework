Array.prototype.includes = function (el) {
  return this.indexOf(el) !== -1;
};

Array.prototype.unique = function () {
  var newArray = [];
  for (var i = 0; i < this.length; i++) {
    if (!newArray.includes(this[i])) {
      newArray.push(this[i]);
    }
  }
  return newArray;
};

Array.prototype.twoSum = function () {
  var newArray = [];
  for (var i = 0; i < (this.length - 1); i++) {
    for (var j = (i + 1); j < this.length; j++) {
      if ((this[i] + this[j]) === 0){
        newArray.push([i, j]);
      }
    }
  }
  return newArray;
};

Array.prototype.myTranspose = function () {
  var newArray = [];
  for (var row = 0; row < this.length; row++) {
    newArray.push([]);
    for (var col = 0; col < this[row].length; col++) {
      newArray[col].push(this[row][col]);
    }
  }
  return newArray;
};
