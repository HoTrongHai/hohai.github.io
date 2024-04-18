+++
title = 'Advance Javascript (Part 1)'
date = 2023-12-12
draft = false
+++

## Advance JS:

### Primitive Datatype

- Strings, Numbers, Booleans, undefined, null, Symbols
- There are object wrappers wrapping these types, then we can access the methods of these objects.

### Objects

- Everything (except primitive types) are `object`
- Object: a collection of values
- Functions are `objects`. The different things are the `internal properties` such as [[Code]], [[Call]]

### Functions are objects

- Function Declaration

```javascript
// Function Declaration
function functionName() {
  // Code block to execute
}
```

- Function Expression

```javascript
// Function Expression
let x = function functionName(val) {
  // Code block to execute
  console.log(val);
};
// Because the function is object, then we can attact the new property
x.userName = "HoHai";
```

- Function contructor

```javascript
// Function contructor
let x = new Function("val", "console.log(val);");
```

### 4 ways to invoke a function

- As a function
- As a method
- As a contructor (`new`)
- Indirectly using `call()` and `apply()`

### Understand `this`

- `this` refer the object that function current called (executed) NOT declared: may be binding object or global object
- Determine at `EXECUTE TIME`, NOT 'DECLARE TIME'

```js
var name = "global";
var obj1 = {
  name: "obj1",
  func1: function () {
    console.log(this.name);
  },
};

obj1.func1(); // The object will be binded this time (executed time), not above

var obj2 = {
  name: "obj2",
  func2: obj1.func1, // Try to refer the func1
};

obj2.func2();
```

```js
var func6 = function () {
  console.log("func6");
};

// func6 is object (function), then we can set other attributes
func6.nameFunc = "func6";
func6.func7 = function () {
  console.log(this);
  console.log(this.nameFunc);
};

func6.func7();
```

### Understanding Prototypes

- Almost Every object is linkedto another object. That linked object is called the prototype
- Inherits and methods from it's prototype ancestry (`prototype chain`)

### `call()`, `apply()` Function methods

- Why we need to invoke function by these way: because we want to determite value of `this`

```js
let func1 = function () {
  console.log("Something...");
};

func1.call(); // Something
func1.apply(); // Something
```

- Using `call`
  `function.call(obj, arg1, arg2 )`:
  The first argument will be come of value of `this`.
  Onr or more arguments to be sent to the function may follow
- Using `apply`
  `function.apply(obj, [arg1, arg2])`:
  The first argument will be come of value of `this`.
  Onr or more arguments to be sent to the function may follow in single array

```js
var user1 = {
  firstName: "Ho",
  lastName: "Hai",
  fullName: function () {
    return this.firstName + " " + this.lastName;
  },
};

var user2 = {
  firstName: "John",
  lastName: "Henry",
  fullName: function () {
    return this.firstName + " " + this.lastName;
  },
};

var greeting = function (term) {
  // the term arg only
  console.log(term + " " + this.firstName); // `this` will be available later
};

greeting.call(user1, "Greeting...");

greeting.apply(user1, ["Greeting2."]);

// Can invoke (extract method from a object then make a call with other object )

console.log(user1.fullName.call(user2));
```

### `bind` method

- `bind` will create new method attached in the binding object

```js
// new method `morningGreet` will be created which attached the `user1` object
var morningGreet = greeting.bind(user1, "Morning", "!");
```

- One or more arguments can be included

```js
var user1 = {
  firstName: "Ho",
  lastName: "Hai",
  fullName: function () {
    return this.firstName + " " + this.lastName;
  },
};

var user2 = {
  firstName: "John",
  lastName: "Henry",
  fullName: function () {
    return this.firstName + " " + this.lastName;
  },
};

var greeting = function (term, term2) {
  // the term arg only
  console.log(term + " " + this.firstName + " " + term2); // `this` will be available later
};
/*
this = user1
term = "Morning"
term2 = undefined
*/

var morningGreet = greeting.bind(user1, "Morning");

/*
term2 = "!"
*/
morningGreet("!"); // Morning Ho !

/*
The object is refered then all of changes will be affected in the binding method
*/
user1.firstName = "Kevin";
morningGreet("!"); // Morning Kevin !

/*
Try to overwrite the refered object by the argument put in `call`
BUT, NOT WORK. The `this` still refer to the binding object
*/

morningGreet.call(user2, "!"); // Morning Ho !
```

### Invoking Functions as Contructors (using `new`)

- `Contructor` is just a function that is invoked using `new`
- `Contructor` returns an `object`
- `Contructors` are used to create `multiple similar objects`

```js
// function with name uppercase the first letter, indicate function can be used with `new'

var Greeting = function () {};

// Create 2 objects
var greet1 = new Greeting();
var greet2 = new Greeting();
```

- the method `fullName` should be put in prototype.
  If we put in the contructor function then we will have multiple methods (it should be shared)

```js
function Users(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;

  this.fullName = function () {
    return this.firstName + " " + this.lastName;
  };
}

var user1 = new Users("Ho", "Hai");
var user2 = new Users("Kevin", "Ho");

console.log(user1.fullName());
console.log(user2.fullName());

// Not the same functions
console.log(user1.fullName === user2.fullName); // False
```
