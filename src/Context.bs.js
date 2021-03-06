// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var React = require("react");

var context = React.createContext(/* Light */0);

var provider = context.Provider;

function Context$ThemeContext$Provider(Props) {
  var value = Props.value;
  var children = Props.children;
  return React.createElement(provider, {
              value: value,
              children: children
            });
}

var Provider = {
  provider: provider,
  make: Context$ThemeContext$Provider
};

var ThemeContext = {
  context: context,
  Provider: Provider
};

function Context$Button(Props) {
  var theme = Props.theme;
  var className = theme ? "theme-black" : "theme-light";
  return React.createElement("button", {
              className: className
            }, "Click me");
}

var Button = {
  make: Context$Button
};

function Context$ThemedButton(Props) {
  var theme = React.useContext(context);
  return React.createElement(Context$Button, {
              theme: theme
            });
}

var ThemedButton = {
  make: Context$ThemedButton
};

function Context$Toolbar(Props) {
  return React.createElement("div", undefined, React.createElement(Context$ThemedButton, {}));
}

var Toolbar = {
  make: Context$Toolbar
};

function Context(Props) {
  return React.createElement(Context$ThemeContext$Provider, {
              value: /* Dark */1,
              children: React.createElement("div", undefined, React.createElement(Context$Toolbar, {}))
            });
}

var make = Context;

exports.ThemeContext = ThemeContext;
exports.Button = Button;
exports.ThemedButton = ThemedButton;
exports.Toolbar = Toolbar;
exports.make = make;
/* context Not a pure module */
