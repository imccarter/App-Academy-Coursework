Function.prototype.myBind = function (context) {
  var fn = this;
  return function () {
    fn.apply(context);
  };
};


function printName(){
  console.log(this.name);
}

var cat = {name: "Nimbus"};
// cat.printName()
// var boundPrintName = printName.myBind(cat);
// boundPrintName();

printName.myBind(cat)();
