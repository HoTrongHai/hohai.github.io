+++
title = 'Advanced Javascript Techniques'
date = 2024-01-19
+++

## Advanced Javascript Techniques

Refer: https://tecadmin.net/advanced-javascript-techniques/

### Closure

- The function can remember `variables` environment (persistent state)

```javascript
// Closures
function counter() {
  let count = 0; // persistent state
  return function () {
    return ++count;
  };
}

const c = counter();
console.log(c()); // 1
console.log(c()); // 2
console.log(c()); // 3
```

### Currying

- A function can be transformed into series functions

```javascript
function add(a, b) {
  return a + b;
}

function curryAdd(a) {
  return function (b) {
    return add(a, b);
  };
}

const add5 = curryAdd(5);
console.log(add5(10)); // Return 15
```

### Memoization

- Caching the results of expensive computations

```javascript
function fibonacci(n) {
    if (n <= 1>) {
        return n;
    }

    return fibonacci(n-1) + fibonacci(n-2);
}

function memoize(func) {
    const cache = {};

    return function(...args) {

    }

}

```

### Prototype

Refer:
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/prototype

![Alt text](./imgs/js-prototype.png)

- A `function` instance (using keyword `new` before function call):
  - New `object` will be returned
  - The `prototype` property will be attacted depend on **returned value** of `function`:
    - In the case return value is `object` then the new object will refer `prototype` of retured value (object).
    - In cases no return or return primitive value, then the new object will refer `prototype` of function calling

```js
// Function 1: no return >> new object (is created by new keyword) will refer to same function's prototype
console.log("Case 1");

function Function1() {}
const obj1 = new Function1();
console.log(Object.getPrototypeOf(obj1) === Function1.prototype); // Return true

// Function 2: return an object >> returned object's prototype is not same to function's prototype

console.log("Case 2");
function Function2() {
  return { a: 1 };
}
const obj2 = new Function2();

console.log(Object.getPrototypeOf(obj2) === Function2.prototype); // Return false, becareful !

// Function 3: return a primitive value

console.log("Case 3");
function Function3() {
  return 1;
}

const obj3 = new Function3();
console.log(Object.getPrototypeOf(obj3) === Function3.prototype); // Return true, becarefull !
```

- We can copy properties/attributes (to reuse functionalities) of object by overwrite the `prototype` property of the function. But need to overwrite at **`Function` prototype**(before initialze `new` object) **AND the case without return or return primitive value**

```js
const mixin = {
  move: function () {
    console.log("I'm moving");
  },

  jump: function () {
    console.log("I'm jumping !");
  },
};

function Function3() {
  return 1;
}

const obj3 = new Function3();
console.log(Object.getPrototypeOf(obj3) === Function3.prototype); // Return true, becarefull !

obj3.prototype = mixin; // Not work
obj3.jump(); // Throw exception

Function3.prototype = mixin; // Work !
const obj4 = new Function3();
obj4.jump(); // I'm jumping !
```

- `this` refer the returned object in `new` keyword

```js
var test;

var Person = function (firstName, lastName) {
  this.firstName = firstName; // Refer to me (later)
  this.lastName = lastName;
  test = this;
};

var me = new Person("Ho", "Hai");
console.log(me);
console.log(me === test); // Return true
```

### Subclass

```js
var Person = function (firstName, lastName) {
  this.firstName = firstName; // `this` refer to later created object (after new keyword)
  this.lastName = lastName;
};

Person.prototype = {
  displayFullName: function () {
    console.log(this.firstName + " " + this.lastName);
  },
};

var me = new Person("Ho", "Hai");
console.log(me); //Person {firstName: 'Ho', lastName: 'Hai'}
// Subclasss

var Employee = function (firstName, lastName, jobTitle) {
  Person.call(this, firstName, lastName);
  this.jobTitle = jobTitle;
};

// Copy the prototype of Employee function instance to Person's prototype

Employee.prototype = Object.create(Person.prototype);

var meDev = new Employee("Ho", "Hai", "Dev");
console.log(meDev); // Employee {firstName: 'Ho', lastName: 'Hai', jobTitle: 'Dev'}

meDev.displayFullName(); // WORK: "Ho Hai"
```
