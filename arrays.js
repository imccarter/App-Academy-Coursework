var includes = function (array, el) {
  var included = false
  for (var i = 0; i < array.length; i++) {
    if (array[i] === el) {
      included = true;
      break;
    }
  }
  return included
}

var unique = function (array) {
  var new_array = [];
  for (var i = 0; i < array.length; i++) {
    if (!includes(new_array, array[i])){
      new_array.push(array[i]);
    }
  }
  return new_array;
}

var twoSum = function (array) {
  var new_array = [];
  for (var i = 0; i < (array.length - 1); i++) {
    for (var j = (i + 1); j < array.length; j++) {
      if ((array[i] + array[j]) === 0){
        new_array.push([i, j]);
      }
    }
  }
  return new_array;
}

var myTranspose = function (array) {
  var new_array = [];
  for (var i = 0; i < array.length; i++) {
    new_array.push([]);
  }

  for (var row = 0; row < array.length; row++) {
    for (var col = 0; col < array[row].length; col++) {
      new_array[col].push(array[row][col])
    }
  }

  return new_array;
}
