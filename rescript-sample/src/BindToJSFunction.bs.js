// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Path = require("path");
var MyGame = require("MyGame");

var root = Path.dirname("/User/github");

MyGame.draw(10, 20, true);

MyGame.draw(10, 20, undefined);

var el = document.getElementById("myId");

var v = Path.join("a", "b");

MyGame.draw();

MyGame.draw("Dog");

MyGame.draw("test", true);

var pad1 = padLeft("Hello World", 4);

var pad2 = padLeft("Hello World", "Message from ReScript: ");

var test1 = testIntType(0);

var test2 = testIntType(20);

var test3 = testIntType(21);

function register(rl) {
  return rl.on("close", (function ($$event) {
                  console.log($$event);
                  
                })).on("line", (function (line) {
                console.log(line);
                
              }));
}

process.on("exit", (function (exitCode) {
        console.log("error code: " + exitCode.toString());
        
      }));

var id = setTimeout((function () {
        console.log("hello");
        
      }), 1000);

var arr = [
    1,
    2,
    3
  ].map(function (x) {
      return x + 1 | 0;
    });

x.onload = (function (v) {
    var o = this ;
    console.log(o.response + v | 0);
    
  });

function test(dom) {
  var elem = dom.getElementById("haha");
  if (elem == null) {
    return 1;
  } else {
    return 2;
  }
}

exports.root = root;
exports.el = el;
exports.v = v;
exports.pad1 = pad1;
exports.pad2 = pad2;
exports.test1 = test1;
exports.test2 = test2;
exports.test3 = test3;
exports.register = register;
exports.id = id;
exports.arr = arr;
exports.test = test;
/* root Not a pure module */
