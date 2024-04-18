+++
title = 'Builder Functions'
date = 2023-12-08
+++

## Function builders

- A function can `contain` a nested function. The nested function can access from parent's variable scope
- A function can `receive` a parameterized function
- A function can be `composed` from other functions

### Nested function

```javascript
// _inner function is nested in highOrderFunc
function highOrderFunc(type) {
  function _inner(thing) {
    // Thing parameter will be visiable at calling time, not definition time
    return thing + type;
  }

  return _inner; // Return the function object, NOT calling function _innner()
}

// Same result, but using arrow style
const highOrderArrowFunc = (type) => (thing) => thing + type;

console.log(highOrderArrowFunc(1)(2)); // Return 3
console.log(highOrderArrowFunc(1)(2)); // Return 3
```

- Use case: We can improve reusage by common the logic

```javascript
const typeOfTest = (type) => (thing) => typeof thing === type;

const isFunction = typeOfTest("function");
const isObject = typeOfTest("object");

function func1() {}
console.log(isFunction(func1)); // True

const obj = {};
console.log(isObject(obj)); // True
```

### Passing a function in parameter

```javascript
function forEach(obj, fn) {
  let i;
  let l; // Define l variable to hold length value, so there is only one time to access the length
  for (i = 0, l = obj.length; i < l; i++) {
    fn.call(null, obj[i], i, obj);
  }
}

const obj = [1, 2, 3];
const myFn = (item, i, obj) => {
  console.log(`Item: ${item}, index: ${i}. Container: ${obj}`);
};

forEach(obj, myFn);
// Item: 1, index: 0. Container: 1,2,3
// Item: 2, index: 1. Container: 1,2,3
// Item: 3, index: 2. Container: 1,2,3
```

### Building function for creating object

- `this` refer to instance object at creation time (`new` keyword)
- `protype` is visible only in `function`. This object will package all of method/properties that the new `object` can access (by `property chain`)

```javascript
function Component(props, context, updater) {
  this.props = props;
  this.context = context;
  // If a component has string refs, we will assign a different object later.
  this.refs = emptyObject;
  // We initialize the default updater but the real one gets injected by the
  // renderer.
  this.updater = updater || ReactNoopUpdateQueue;
}

Component.prototype.isReactComponent = {};
Component.prototype.setState = function (partialState, callback) {
  if (
    typeof partialState !== "object" &&
    typeof partialState !== "function" &&
    partialState != null
  ) {
    throw new Error(
      "setState(...): takes an object of state variables to update or a " +
        "function which returns an object of state variables."
    );
  }

  this.updater.enqueueSetState(this, partialState, callback, "setState");
};
```
