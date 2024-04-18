+++
title = 'Builder Module'
date = 2023-12-11
+++

## Builder module

- Extract properties of object to reuse these properties

```javascript
const { toString } = Object.prototype;
const { getPrototypeOf } = Object;
const { isArray } = Array;
```

### Abstraction

- Each significant of functionality should be implement in just one place
