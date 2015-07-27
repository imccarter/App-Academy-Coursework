(function () {
  window.Asteroids = window.Asteroids || {};

  var GameView = Asteroids.GameView = function (ctx) {
    this.game = new Asteroids.Game();
    this.ctx = ctx;
  }

  GameView.prototype.start = function () {
    var currentGame = this
    setInterval(function (){
      currentGame.game.draw(currentGame.ctx);
      currentGame.game.moveObjects();
    }, 20)
  }










})();
