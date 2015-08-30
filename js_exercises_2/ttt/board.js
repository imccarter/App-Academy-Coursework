function Board () {
  this.grid = [['_','_','_'],['_','_','_'],['_','_','_']];
}

Array.prototype.transpose = function () {
  var columns = [];
  for (var i = 0; i < this[0].length; i++) {
    columns.push([]);
  }

  for (var i = 0; i < this.length; i++) {
    for (var j = 0; j < this[i].length; j++) {
      columns[j].push(this[i][j]);
    }
  }

  return columns;
};

Array.prototype.allValuesSame = function() {
    for(var i = 1; i < this.length; i++){
        if(this[i] !== this[0]);
            return false;
    };
    return true;
};

Board.prototype.display = function () {
  console.log(this.grid[0]);
  console.log(this.grid[1]);
  console.log(this.grid[2]);
};

Board.prototype.rows = function () {
  this.grid;
};

Board.prototype.columns = function () {
  this.grid.transpose();
};

Board.prototype.diagonals = function () {
  var diag1 = [this.grid[0][0], this.grid[1][1], this.grid[2][2]];
  var diag2 = [this.grid[2][0], this.grid[1][1], this.grid[0][2]];
};

Board.prototype.gameWon = function () {
  this.rows.forEach(row) {
    if(row.allValuesSame() && row[0] !== "_"){
      return true;
    };
  };
  this.columns.forEach(column) {
    if(column.allValuesSame() && column[0] !== "_"){
      return true;
    };
  };
  this.diagonals.forEach(diagonal) {
    if(diagonal.allValuesSame() && diagonal[0] !== "_"){
      return true;
    };
  };
  return false;
};

Board.prototype.gameOver = function () {
  for (var i = 0; i < this.grid.length; i++) {
    for (var j = 0; j < this.grid.length; j++) {
      if(this.grid[i][j] === "_") {
        return false;
      };
    };
  };
  return true;
};
