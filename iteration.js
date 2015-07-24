var bubbleSort = function (array) {
  var sorted = false;
  while (!sorted) {
    sorted = true;
    for (var i = 0; i < array.length - 1; i++) {
      if (array[i] > array[i + 1]) {
        sorted = false;
        var temp = [array[i + 1], array[i]];
        array[i] = temp[0];
        array[i + 1] = temp[1];
      }
    }
  }
  return array;
};

var substrings = function(string) {
  var subStrings = [];
  for (var i = 0; i < string.length; i++) {
    for (var j = i + 1; j <= string.length; j++) {
      subStrings.push(string.substring(i, j));
    }
  }
  return subStrings;
};
