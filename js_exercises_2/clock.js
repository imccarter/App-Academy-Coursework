function Clock() {
  this.currentTime = new Date();
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  var seconds = this.currentTime.getSeconds();
  var minutes = this.currentTime.getMinutes();
  var hours = this.currentTime.getHours();
  console.log(hours + ":" + minutes + ":" + seconds);
};

Clock.prototype.run = function () {
  this.currentTime = new Date();
  this.printTime()
  setInterval(this._tick.bind(this), Clock.TICK)
};


Clock.prototype._tick = function () {
  var time = this.currentTime.valueOf()
  this.currentTime.setTime(time + Clock.TICK)
  this.printTime()
}

var clock = new Clock()

module.exports = Clock;
