// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Curry = require("rescript/lib/js/curry.js");
var React = require("react");

function reducer(state, action) {
  if (action) {
    return {
            count: state.count - 1 | 0
          };
  } else {
    return {
            count: state.count + 1 | 0
          };
  }
}

function UseReducer(Props) {
  var match = React.useReducer(reducer, {
        count: 0
      });
  var dispatch = match[1];
  return React.createElement(React.Fragment, undefined, "Count:" + String(match[0].count), React.createElement("button", {
                  onClick: (function (param) {
                      return Curry._1(dispatch, /* Dec */1);
                    })
                }, "-"), React.createElement("button", {
                  onClick: (function (param) {
                      return Curry._1(dispatch, /* Inc */0);
                    })
                }, "+"));
}

function init(initialCount) {
  return {
          count: initialCount
        };
}

function reducer$1(state, action) {
  if (typeof action === "number") {
    if (action !== 0) {
      return {
              count: state.count - 1 | 0
            };
    } else {
      return {
              count: state.count + 1 | 0
            };
    }
  } else {
    return {
            count: action._0
          };
  }
}

function UseReducer$make1(Props) {
  var initialCount = Props.initialCount;
  var match = React.useReducer(reducer$1, initialCount, init);
  var dispatch = match[1];
  return React.createElement(React.Fragment, undefined, "Count:" + String(match[0].count), React.createElement("button", {
                  onClick: (function (param) {
                      return Curry._1(dispatch, /* Dec */1);
                    })
                }, "-"), React.createElement("button", {
                  onClick: (function (param) {
                      return Curry._1(dispatch, /* Inc */0);
                    })
                }, "+"));
}

var make = UseReducer;

var make1 = UseReducer$make1;

exports.make = make;
exports.init = init;
exports.reducer = reducer$1;
exports.make1 = make1;
/* react Not a pure module */