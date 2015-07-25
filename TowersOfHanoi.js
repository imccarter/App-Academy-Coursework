var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


function HanoiGame(){
  this.stacks = [[1, 2, 3],[],[]]
}

HanoiGame.prototype.isWon = function () {
  if ( this.stacks[1].length === 3 || this.stacks[2].length === 3 ){
    return true;
  }
  return false;
};

HanoiGame.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
  if((this.stacks[startTowerIdx][0] < this.stacks[endTowerIdx][0]) || this.stacks[endTowerIdx].length === 0){
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.move = function (startTowerIdx, endTowerIdx) {
  var towers = this.stacks;
  debugger;
  if(this.isValidMove(startTowerIdx, endTowerIdx)){
    this.stacks[endTowerIdx].unshift(this.stacks[startTowerIdx].shift());
    return true;
  } else {
    return false;
  };
};

HanoiGame.prototype.print = function () {
  towers = this.stacks
  console.log(JSON.stringify(towers));
}

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  reader.question("Pick start tower", function(startTower) {
    reader.question("Pick end tower", function(endTower) {
      var startTowerIdx = parseInt(startTower);
      var endTowerIdx = parseInt(endTower);

      callback(startTowerIdx, endTowerIdx);
    });
  });
};

HanoiGame.prototype.run = function (completionCallback) {
  var that = this
  this.promptMove( function (a, b) {
    if(that.move(a, b)){
      if(that.isWon()){
        console.log("You won!");
        completionCallback();
      } else {
        that.run(completionCallback);
      }
    } else {
      console.log("Invalid move");
    }
  });
}

var hanoi = new HanoiGame()

hanoi.run(function () {
  console.log("Game over!");
  reader.close();
})
