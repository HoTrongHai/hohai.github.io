+++
title = 'Object Prototypes'
date = 2023-12-03
+++

## Object Prototypes

Refer to:

- https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/Object_prototypes

### Prototypes

- Prototype is object, to reuse the feature/function.
- Every **object have a prototype** (similar to a layer that build up to object). May be we can think like the `base image` in `docker`
- Prototype chain:

```shell
myObject.__proto__ >> myObject.__proto__.__proto__ (refer a prototype of prototype of my object)...>> until null

myObject.__proto__  === Object.getPrototypeOf(myObject)
```

- To access a prototype object we can use one of ways

```javascript
myObject.__proto__;
Object.getPrototypeOf(myObject);

myObject.__proto__ === Object.getPrototypeOf(myObject); // Will be true
```

- The attributes (fields/methods) will be lookup by the prority:
  - Lookup at self object. Example `myObject.AttributeWantToLookup`
  - Then lookup in prototype chain:
    ```javascript
    myObject.__proto__.AttributeWantToLookup >> myObject.__proto__.__proto__.AttributeWantToLookup... until found or null
    ```

### Setting prototype

We can put an object is prototype of other object by

- Use `__proto__` directly:

```javascript
const o = {
  a: 1,
  someMethod: function () {
    console.log("TODO");
  },
};
const p = { b: 2, __proto__: a };
```

- Use constructor functions:

```javascript
function Graph() {
  this.vertices = [];
  this.edges = [];
}

Graph.prototype.addVertex = function (v) {
  this.vertices.push(v);
};

const g = new Graph();
// g is an object with own properties 'vertices' and 'edges'.
// g.[[Prototype]] is the value of Graph.prototype when new Graph() is executed.
```

- Use `Object.create`

  ```javascript
  const obj1 = {...}
  const obj2 = Object.create(obj1) // obj1 will be a prototype of obj2
  ```

- Use `Classes`

```javascript
class Rectangle {
  constructor(height, width) {
    this.name = "Reatangle";
    this.height = height;
    this.width = width;
  }

class FilledRectangle extends Rectangle {
  contructor(height, width, color) {
    super(height, width);
    this.name = "Filled Rectangle";
    this.color = color;
  }

}

const filledRectangle = new FilledRectangle(5, 10, "blue");
// filledRectangle >> FilledRectangle.prototype >> Rectangle.prototype >> Object.prototype >> null
}

```

- Use `Object.setPrototypeOf`:

  ```javascript
  function Base() {}
  function Derived() {}
  // Set the `[[Prototype]]` of `Derived.prototype`
  // to `Base.prototype`
  Object.setPrototypeOf(Derived.prototype, Base.prototype);

  const obj = new Derived();
  // obj ---> Derived.prototype ---> Base.prototype ---> Object.prototype ---> null
  ```

- Use `prototype` property of function
  Every functions have a property called `protype` then we can assign this property with the prototype object

  ```javascript
  const obj1 = {
    hello: function () {
      console.log("Hello from reuse function");
    },
  };
  function Object2(someValue) {
    this.someAttribute = someValue;
  }

  Object.assign(Object2.prototype, obj1);

  const obj2 = new Object2("AAA");
  ```

### Prototypes: Reuse of set properties

```javascript
const boxes = [
  {
    value: 1,
    getValue() {
      return this.value;
    },
  },
  {
    value: 2,
    getValue() {
      return this.value;
    },
  },
  {
    value: 3,
    getValue() {
      return this.value;
    },
  },
];

console.log(boxes[0].getValue());
console.log(boxes[1].getValue());
console.log(boxes[2].getValue());

// The getValue can be reusable of boxed. Then we can define a prototype object having getValue method. After that we define __proto__ property of each box refer the prototype object

const getValueProto = {
  getValue() {
    return this.value;
  },
};

const boxes_2 = [
  { value: 1, __proto__: getValueProto },
  { value: 2, __proto__: getValueProto },
  { value: 3, __proto__: getValueProto },
];

console.log(boxes_2[0].getValue());
console.log(boxes_2[1].getValue());
console.log(boxes_2[2].getValue());
```

- Contructor

```javascript
function Box(value) {
  this.value = value; // This will be refer later (the binding object)
}

Box.prototype.getValue = function () {
  return this.value;
};

// At the create time, all of attributes of parent will be copied into new object
// Including the attributes of prototype also.

const box1 = new Box(1);
console.log(box1.value);
console.log(box1.getValue()); // 1
```

- We can change the attribute of prototype, then the `new value` will be applied

```javascript
function Box(value) {
  this.value = value;
}

Box.prototype.getValue = function () {
  return this.value;
};

const box1 = new Box(1);
console.log(box1.getValue());

// Try to change the prototype function
Box.prototype.getValue = function () {
  return this.value + 1;
};

console.log(box1.getValue()); // 2 (the new prototype is applied)
```

- Bad idea if we attach built-in prototype with new attributes (because of the new attributes may be change in future). For example
  This is call **monkey patching**

```javascript
const myArr = [1, 2, 3];

Array.prototype.hohai_map = function () {
  console.log("From my HoHai");
};

myArr.hohai_map();
```

- I will try to create own `forEach` by using `prototype`.

```javascript
Array.prototype.myForEach = function (func) {
  for (let i = 0; i < this.length; i++) {
    func(this[i]);
  }
};

const arr1 = [1, 2, 3];

arr1.myForEach((e) => console.log(`Element: ${e}`));
```

### TODO:

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Closures
- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Inheritance_and_the_prototype_chain
