// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Caml_array = require("rescript/lib/js/caml_array.js");

var myArray = [
  "hello",
  "world",
  "how are you"
];

var array = [
  "hello",
  "world",
  "how are you"
];

var firstItem = Caml_array.get(array, 0);

Caml_array.set(array, 0, "hey");

var myList = {
  hd: 1,
  tl: {
    hd: 2,
    tl: {
      hd: 3,
      tl: /* [] */0
    }
  }
};

var anotherList = {
  hd: 0,
  tl: myList
};

var message = myList ? "The head of the list is the string" + (1).toString() : "This list is empty";

exports.myArray = myArray;
exports.array = array;
exports.firstItem = firstItem;
exports.myList = myList;
exports.anotherList = anotherList;
exports.message = message;
/*  Not a pure module */