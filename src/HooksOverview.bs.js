// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Curry = require("rescript/lib/js/curry.js");
var React = require("react");

function HooksOverview(Props) {
  var match = React.useState(function () {
        return 0;
      });
  var setCount = match[1];
  var onClick = function (_evt) {
    return Curry._1(setCount, (function (prev) {
                  return prev + 1 | 0;
                }));
  };
  var msg = "You clicked" + String(match[0]) + "times";
  return React.createElement("div", undefined, React.createElement("p", undefined, msg), React.createElement("button", {
                  onClick: onClick
                }, "Click me"));
}

var make = HooksOverview;

exports.make = make;
/* react Not a pure module */
