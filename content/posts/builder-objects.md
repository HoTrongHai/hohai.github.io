+++
title = 'Builder Objects'
date = 2023-12-09
+++

## Object Builder

How we define object and attribute correctly

### Think like objects

- It's easy if we abstract everything is `object` (both of Javascript/Python...). Because it's modeling the problem and due to escapsulation we can ignore the detail implementation if need.
- In Javascript functions is `function`, but we can think they should be objects also.

  - `function` = **callable** `object`
  - `function` = `protoptype` (aka class) to init object
  - `function` **has** a `prototype` object
  - `function` may not belong an `object`. When `function` belong an `object`, it called `method`

    ```javascript
    function someFunc() {
      this.myValue = 1;
      return "AAA";
    }

    // Then we can init object by the new keyword on function calling
    const obj = new someFunc();
    // The object will be create with someFunc class
    /*
    {
        myValue: 1,
        [[Prototype]]: Object
    }
    */

    // Only function have prototype object
    console.log(someFunc.prototype);
    ```

- In Python: Everything is object.

### Create objects

- By Object literal

```js
let object = {
  firstName: "Ho",
  lastName: "Hai",
};
```

- Object contructor

```js
let obj = new Object();
obj.firstName = "Ho";
obj.lastName = "Hai";
```

### Object in modules

What's happend if we import an `object` from module (js file).

- The object will be same in the declared module and imported module
- We can modify the object, then the changes will be reflected at all.

```javascript
// In lib1.js
const myObject = { a: 1 };

// In main.js we will import and print out the object
import { myObject } from "./lib1.js";
console.log(myObject); // {a: 1}

// In lib2.js
// Now we will add new module that try to import the `myObject` from lib1 and change
// this object by adding new attribute
import { myObject } from "./lib1.js";

function changeInMyObject() {
  myObject.b = 2;
}

export { changeInMyObject };

// In main.js
import { myObject } from "./lib1.js";
import { changeInMyObject } from "./lib2.js";

console.log(myObject); // {a: 1}

changeInMyObject();

console.log(myObject); // {{a: 1, b: 2} >> WORKS (refer the same object in lib1, lib2)
```

### Increment buiding object

We can build and setup properties/attributes of `objects` by:

- Design `static` properties/attributes by `class`. From the `class` we can init new `object`
- Attact new `dynamic` properties/attributes at runtime.

### Design static properties/attributies by class/function

- In `class`:
  - The `contructor` is function anymore
  - `this` refer to the instance object

```javascript
class BaseClass {
  contructor(baseValue) {
    this.baseValue = baseValue;
  }
  baseMethod1(a) {}
  baseMethod2(a, b) {}
}
class MyClass extends BaseClass {
  constructor(value) {
    super(value);
  }

  newMethod1() {}
}

const myInstance = new MyClass("HoHai");

// Then we can access the property by: dot notation or dictionary access style
myInstance["baseMethod1"] === myInstance.baseMethod1; // Return True
```

- In `function`
  - `this` refer to `global object` (for example `window`) if we don't put the `new` keyword
  - `this` refer to the instance of new object if we put the `new` keyword

```javascript
function myClassFunction(a, b) {
  console.log(this);
  this.a = a;
  this.b = b;

  this.baseMethod = function (c) {
    console.log(c);
  };

  return "Some value when calling the myClassFunction";
}

const myInstance = new myClassFunction(1, 2);
myInstance.baseMethod(3);
```

### Attact new `dynamic` properties at runtime

```javascript
const emptyObject = {}; // Using object literal (Object.create(null) will be returned the same result)
emptyObject.myValue = 1;
emptyObject.myFunc = function (a, b) {
  return a + b;
};

emptyObject["New Dynamic Property"] = "New Value";
```

### Check a property in object

- Using `in`:

```js
const obj = {};
console.log("lastName" in obj);
```

- `hasOwnProperty` method

```js
console.log(obj.hasOwnProperty("greeting"));
```

### Function and object

```js
const b = {
  b1: 11,
  b2: "AA",
  getb1: function () {
    return this.b1;
  },
};

const a = {
  a1: b.getb1(),
  a2: b.b2,
};

const aFunc = function () {
  return {
    a1: b.getb1(),
    a2: b.b2,
  };
};

console.log(a);

console.log(aFunc());

b.b1 = 22;
b.b2 = "BB";
console.log(a);
console.log(aFunc());
```
