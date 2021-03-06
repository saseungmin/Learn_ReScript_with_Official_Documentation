// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Curry = require("rescript/lib/js/curry.js");
var React = require("react");

var $$Document = {};

function UseEffect(Props) {
  var match = React.useState(function () {
        return 0;
      });
  var setCount = match[1];
  var count = match[0];
  React.useEffect((function () {
          document.title = "You clicked " + String(count) + " times!";
          
        }), [count]);
  var onClick = function (_evt) {
    return Curry._1(setCount, (function (prev) {
                  return prev + 1 | 0;
                }));
  };
  var msg = "You clicked" + String(count) + "times";
  return React.createElement("div", undefined, React.createElement("p", undefined, msg), React.createElement("button", {
                  onClick: onClick
                }, "Click me"));
}

var ChatAPI = {};

function UseEffect$make1(Props) {
  var friendId = Props.friendId;
  var match = React.useState(function () {
        return /* Offline */0;
      });
  var setState = match[1];
  React.useEffect(function () {
        var handleStatusChange = function (status) {
          return Curry._1(setState, (function (param) {
                        if (status.isOnline) {
                          return /* Online */2;
                        } else {
                          return /* Offline */0;
                        }
                      }));
        };
        subscribeToFriendStatus(friendId, handleStatusChange);
        Curry._1(setState, (function (param) {
                return /* Loading */1;
              }));
        return (function (param) {
                  unsubscribeFromFriendStatus(friendId, handleStatusChange);
                  
                });
      });
  var text;
  switch (match[0]) {
    case /* Offline */0 :
        text = friendId + " is offline";
        break;
    case /* Loading */1 :
        text = "loading...";
        break;
    case /* Online */2 :
        text = friendId + " is online";
        break;
    
  }
  return React.createElement("div", undefined, text);
}

var test = "";

var make = UseEffect;

var make1 = UseEffect$make1;

exports.test = test;
exports.$$Document = $$Document;
exports.make = make;
exports.ChatAPI = ChatAPI;
exports.make1 = make1;
/* react Not a pure module */
