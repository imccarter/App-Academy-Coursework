(function () {
  window.Asteroids = window.Asteroids || {};

  var Game = Asteroids.Game = function () {
    this.asteroids = [];
    this.addAsteroids();
  };

  Game.DIM_X = 1000;
  Game.DIM_Y = 500;
  Game.NUM_ASTEROIDS = 8;

  Game.prototype.addAsteroids = function () {
    for (var i = 0; i < Game.NUM_ASTEROIDS; i++) {
      this.asteroids.push(new Asteroids.Asteroid({'pos': this.randomPosition(), 'game': this}));
    }
  };

  Game.prototype.randomPosition = function () {
    return [Math.random() * Game.DIM_X, Math.random() * Game.DIM_Y];
  };



  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
    this.asteroids.forEach(function (asteroid) {
      asteroid.draw(ctx);
    });
  };

  Game.prototype.moveObjects = function () {
    this.asteroids.forEach(function (asteroid) {
      asteroid.move();
    });
  };

  Game.prototype.wrap = function (pos) {
    var wrappedPos = [];
    if (pos[0] >= Game.DIM_X) {
      wrappedPos[0] = Math.abs(pos[0] % Game.DIM_X);
    } else if (pos[0] < 0) {
      wrappedPos[0] = Game.DIM_X - Math.abs(pos[0] % Game.DIM_X);
    } else {
      wrappedPos[0] = pos[0];
    }
    if (pos[1] >= Game.DIM_Y) {
      wrappedPos[1] = Math.abs(pos[1] % Game.DIM_Y);
    } else if (pos[1] < 0) {
      wrappedPos[1] = Game.DIM_Y - Math.abs(pos[1] % Game.DIM_X);
    } else {
      wrappedPos[1] = pos[1];
    }

    return wrappedPos;
  };

  Game.prototype.checkCollisions = function () {
    for (var current = 0; current < this.asteroids.length; current++) {
      for (var other = current + 1; other < this.asteroids.length; other++) {
        var currentAsteroid = this.asteroids[current];
        var otherAsteroid = this.asteroids[other];
        if (currentAsteroid.isCollidedWith(otherAsteroid)) {
          currentAsteroid.collideWith(otherAsteroid);
        }
      }
    }
  };

  Game.prototype.remove = function (asteroid) {
    var newAry = this.asteroids.filter(function (el){
      return el !== asteroid;
    });
    this.asteroids = newAry;
  };
})();
