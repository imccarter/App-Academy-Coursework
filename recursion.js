var recursiveRange = function(start, end) {
  if (end < start) {
    return [];
  } else {
    return [start].concat(recursiveRange(start + 1, end));
  }
};

var iterRange = function(start, end) {
  var rangeAry = [];
  for (var i = start; i <= end; i++) {
    rangeAry.push(i);
  }
  return rangeAry;
};

var exponentiation1 = function (base, exp) {
  if (exp === 0) {
    return 1;
  } else {
    return base * exponentiation1(base, exp-1);
  }
};

var exponentiation2 = function (base, exp) {
  if (exp === 0) {
    return 1;
  } else if (exp === 1) {
    return base;
  } else if (exp % 2 === 0){
    var recExp = exponentiation2(base, exp/2);
    return recExp * recExp;
  } else {
    var recExp2 = exponentiation2(base, (exp - 1) / 2);
    return base * recExp2 * recExp2;
  }
};

var fibonacci = function (n) {
  // if (n <= 2) { return [0, 1].slice(0, n) }
  if (n <= 2) {
    return [0, 1].slice(0, n);
  } else {
    var temp = fibonacci(n-1);
    temp.push(temp[temp.length - 1] + temp[temp.length - 2]);
    return temp;
  }
};

var bSearch = function (array, target) {
  var midpoint = Math.floor(array.length / 2);
  if (array.length === 0) {
    return null;
  } else if (array[midpoint] === target) {
    return midpoint;
  } else if (array[midpoint] < target) {
    var rightHalf = bSearch(array.slice(midpoint + 1, array.length), target);
    if (rightHalf !== null) {
      return midpoint + 1 + rightHalf;
    } else { return null; }
  } else {
    return bSearch(array.slice(0, midpoint), target);
  }
};

var makeChange1 = function (amt, coins) {
  if (amt <= 0){
    return [];
  } else if (amt < coins[coins.length - 2]) {
    var change = [];
    for (var i = 0; i < amt; i++) {
      change.push(coins[coins.length - 1]);
    }
    return change;
  } else if (amt >= coins[0]) {
    var numCoins = Math.floor(amt / coins[0]);
    var amountLeft = amt % coins[0];

    var moreChange = [];
    for (var j = 0; j < numCoins; j++) {
      moreChange.push(coins[0]);
    }

    return moreChange.concat(makeChange1(amountLeft, coins.slice(1)));
  } else {
    return makeChange1(amt, coins.slice(1));
  }
};

var makeChange2 = function (amt, coins) {
  var best = [];
  if (amt <= 0){
    return [];
  } else {
    var solution = [];
    coins.forEach(function (coin) {
      var newAmount = amt - coin;
      if (coin > amt) {
        solution = makeChange2(amt, coins.slice(1));
      } else {
        solution = [coin].concat(makeChange2(newAmount, coins));
      }

      if (best.length === 0 && solution !== []){
        best = solution;
      } else if (solution !== [] && solution.length < best.length){
        best = solution;
      }
    });
  }
  return best;
};

Array.prototype.mergeSort = function () {
  if (this.length <= 1) {
    return this;
  } else {
    var halfway = Math.floor(this.length / 2);
    var left = this.slice(0, halfway);
    var right = this.slice(halfway);
    return merge(left.mergeSort(), right.mergeSort());
  }
};

var merge = function (arr1, arr2) {
  var output = [];
  while (arr1.length > 0 && arr2.length > 0) {
    if (arr1[0] > arr2[0]) {
      output.push(arr2.shift());
    } else {
      output.push(arr1.shift());
    }
  }
  // output = output.concat(arr1);
  // output = output.concat(arr2);
  return output.concat(arr1).concat(arr2);
};

Array.prototype.subsets = function () {
  if (this.length === 0) {
    return [[]];
  } else {
    var mostSubs = this.slice(0, this.length - 1).subsets();
    var mostSubs2 = [];
    var self = this;
    mostSubs.forEach(function (el) {
      mostSubs2.push(el.concat(self[self.length - 1]));
    });
    return mostSubs.concat(mostSubs2);
  }
};
