+++
title = 'Build Objects'
date = 2024-02-21
+++

### `new` in function call

{{< mermaid >}}
graph
A["var john = new Person()"]
B["{} - 0x001 in memory"]
C["function Person()<br> (without returned value)<br><b>FUNCTION CONSTRUCTOR</b>"]
D["function Person()<br> (with returned value)"]
E["var john (refer to returned value)"]

    A--new-->B
    B--incase OK, function without return value<br>change pointer <b>this</b> = {} -->C
    C--update {}-0x001 and assign to variable -->A
    B--incase NOK, function with return value<br>change pointer <b>this</b> = {} --> D
    D-->E


    style C fill:#4287f5

{{< /mermaid >}}

```js
function Person(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
}

var john = new Person("John", "Doe");
var jane = new Person("Jane", "Doe");

console.log(john);
console.log(jane);
```

- We can add new features for objects after creation >> **PERFECT** !!!
  - If we add new features at function contructor, then every execute the function contructor, the **new of instance features** (functions are objects) will **take memory space**
  - We can add o**ne (single object)** to share all objects at prototype

```js
function Person(firstName, lastName) {
  console.log(this);
  this.firstName = firstName;
  this.lastName = lastName;
}

var john = new Person("John", "Doe");
var jane = new Person("Jane", "Doe");

console.log(john);
console.log(jane);

// We can add new features for objects after creation >> PERFECT !!!
Person.prototype.getFullName = function () {
  return this.firstName + " " + this.lastName;
};

// console.log(john.getFullname === jane.getFullname); // True

console.log(john.getFullName());
```

### Builin Functions Extension

- We can extend features/functions by attact them to `prototype`. Such as Javascript Engine wrapup the primitve value by the Object.

```js
var aString = new String("Hello");
// Then we can use the toLocatedString() in String.prototype

aString.toLocateString();
```

- From above idea, we can attach new features for the current objects of library/frameworks

```js
String.prototype.isLengGreaterThan = function (limit) {
  return this.length > limit;
};

console.log("HoHai".isLengGreaterThan(3)); // True
```

### `Object.create()`

- To create new object from existen object which can be refer as `__proto__` property

```js
var person = {
    firstName = "Default",
    lastName = "Default",
    greet: function() {
        return "Hi " + this.firstName
    }
}

// Set __proto__ of the new object (john) is person object
var john = Object.create(person);
// Can overwrite other properties
john.firstName = "John";
console.log(john)

```

- **Polyfill**: Add new features that the framework/Java Engine **may lack**.
  For example, there is some **lacked features** of Java Engine from old browsers version. Then we need to fullfill these features to adapt with new browsers versions.
  Example of polyfill for `Object.create`

  ```js
  // Polyfill
  if (!Object.create) {
    Object.create = function(obj) {

      if (arguments.length > 1) {
        throw new Error('Object.create implementation only accepts the first parameter')
      }

      function F {};
      F.prototype = obj;
      return new F();
    }
  }
  ```

### ES6 and Classes

```js
class Person {
  constructor(firstName, lastname) {
    this.firstName = firstName;
    this.lastname = lastname;
  }

  greet() {
    return "Hi " + this.firstName;
  }
}

var person1 = new Person("hai", "ho");
var person2 = new Person("hai2", "ho");

console.log(person1.greet === person2.greet); // Refer to the same function object (greet)
```

### jQuery concepts

### TODO

- https://learn.jquery.com/code-organization/concepts/
