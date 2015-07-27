(function () {
  window.Asteroids = window.Asteroids || {};

  var MovingObject = Asteroids.MovingObject = function (options) {
    this.pos = options.pos;
    this.vel = options.vel;
    this.color = options.color;
    this.radius = options.radius;
  }

  MovingObject.prototype.draw = function (ctx) {
    ctx.beginPath();
    ctx.arc(
      this.pos[0],
      this.pos[1],
      this.radius,
      0,
      2 * Math.PI,
      true
    );
    ctx.fillStyle = this.color;
    ctx.fill();
  };

  MovingObject.prototype.move = function () {
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
  };

})();
