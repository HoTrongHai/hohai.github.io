+++
title = 'This keyword in Javascript'
date = 2023-12-06
+++

## This keyword in Javascript

### `this` alone

- Refer to global object. In node.js `this` will be undefined.
- In browser will return the window object. But for using "use strict", this will be return `undefined`

```javascript
console.log(this);
const x = this;
```

### `this` in function

- Without `new` calling function >> refer to global object
- With `new` calling function >> refer to new instance object

```javascript
function thisInFunc() {
  console.log(this);
}

thisInFunc(); // Undefine in node.js or strict mode
new thisInFunc(); // new object
```

### In `call()` function binding

```javascript
const objectWithReuseMethod = {
  displayFullName: function () {
    return this.firstName + " " + this.lastName;
  },
};

const person = {
  firstName: "Ho",
  lastName: "Hai",
};

// Then we can extract the `displayFullName` method then make call with other object (person in this case)
const fullName = objectWithReuseMethod.displayFullName.call(person);
console.log(fullName); // "Ho Hai"
```

### In `bind()` Function Borrowing

- Similar to `call()`
- Different between `call()`, `bind()`, `apply()`:
  https://stackoverflow.com/questions/15455009/javascript-call-apply-vs-bind
