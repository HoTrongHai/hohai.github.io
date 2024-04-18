+++
title = 'Advance Javascript (Part 2)'
date = 2023-12-15T07:07:07+01:00
draft = false
+++

### Higher Functions, Callbacks

- Higher function are functions that operate on other functions (by taking them as arguments or returning them)

- `this` refer to global object

```js
var fullName = function () {
  setTimeout(function () {
    // `this` will refer to global object
    console.log(this.firstName + " " + this.lastName);
  }, 1000);
};
fullName.call({
  firstName: "Ho",
  lastName: "Hai",
}); // undefined undefined
```

- Can fix by hacking
  - Option 1: store `this` object in higher function

```js
var fullName = function () {
  let that = this;
  setTimeout(function () {
    // `this` will refer to global object
    console.log(that.firstName + " " + that.lastName);
  }, 1000);
};
fullName.call({
  firstName: "Ho",
  lastName: "Hai",
});
```

- Using `bind`: will create new method with binding the `this` object from higher function

```js
var fullName = function () {
  setTimeout(
    function () {
      // `this` will refer to global object
      console.log(this.firstName + " " + this.lastName);
    }.bind(this),
    1000
  );
};
fullName.call({
  firstName: "Ho",
  lastName: "Hai",
});
```

- Or can fix by using `Arrow functions`

### Arrow functions

- Minimal syntax
- Solve `this` problem

```js
var fullName = function () {
  setTimeout(() => {
    // `this` will refer to global object
    console.log(this.firstName + " " + this.lastName);
  }),
    1000;
};
fullName.call({
  firstName: "Ho",
  lastName: "Hai",
});
```
