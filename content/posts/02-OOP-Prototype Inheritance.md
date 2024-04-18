### Classical Inheritance vs Prototype Inheritance

- Classical Inheritance: like C#, Java...
- Prototypal Inheritance: Javascript

### Prototype

- Prototype chain: the links that Javascript can search from current object to `__proto__` parent object (and so on)

```mermaid
graph
A["Obj"]
B["prop-1"]
C["__proto__"]
D["prop-2"]
E["__proto__"]
F["prop-3"]
G["Obj2"]
H["..."]




A-->B
A-->C
C-->D
C-->E
E-->F
G--share same object (memory)-->C
E-->H
```

### Everthing is an Object (or a primitive)

```mermaid
graph
D["Object"]
E["function"]
F["Array"]

A["__proto__: Object-builtin<br>{toString: f,..}"]
B["__proto__: Funcion-builtin<br>{call:f,..}"]
C["__proto__: Array-builtin<br>{push:f,...}"]



D--Javascript Engine plug-->A
E--Javascript Engine plug-->B
F--Javascript Engine plug-->C

B--__proto__-->A
C--__proto__-->A


```

### Reflection and Extend

- Reflection: An object can look at **itself**, listing and changing its properties and methods
- Extend: some kind of composition by copied properties and method of source project to destinition. In `Underscore.js` we can user `_.extend(des, source1, source2...)`

```mermaid
graph
    A["John<br>{f1, f2}"]
    B["Jane<br>{f3}"]
    C["Jim<br>{f4, f5}"]
    D["extend"]
    E["John<br>{f1, f2, f3,f4, f5}"]

    A-->D
    B-->D
    C-->D
    D-->E
```
