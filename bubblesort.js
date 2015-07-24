var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function askIfGreaterThan(el1, el2, callback) {
  reader.question("Is " + el1 + " greater than " + el2 + "?", function (answer) {
    var ans = answer;

    if(ans === "yes"){
      callback(true);
    } else {
      callback(false);
    }
  });
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop){
  if(i < arr.length - 1){
    askIfGreaterThan(arr[i], arr[i + 1], function(isGreaterThan) {
      if(isGreaterThan){
        var temp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = temp;
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, (i + 1), madeAnySwaps, outerBubbleSortLoop);
    });
  } else {
    outerBubbleSortLoop(madeAnySwaps);
  };
};

function absurdBubbleSort(arr, sortCompletionCallback) {
  function outerBubbleSortLoop(madeAnySwaps) {
    if(madeAnySwaps){
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    };
  };
  outerBubbleSortLoop(true);
};

absurdBubbleSort([6, 8, 2, 4, 1, 9], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
