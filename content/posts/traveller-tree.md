+++
title = 'Traveller Tree'
date = 2024-03-20
+++

# traveller-tree

This lib provide 2 features:

- Get schema of json object
- Flat json object into array of elements.

### Install

```shell
npm install traveller-tree
```

### Get schema of json object

```js
travelSchema({
        A: {
          B: "A String",
          C: 123,
          D: {
            D1: "D1 String",
            D2: "D2 String",
          },
          E: [
            {
              E1: "E1 in element 1",
            },
            {
              E1: "E1 in element 2",
            },
          ],
        },
      })
    )
```

### Flat nested json to array of flat objects

- Option 1: Using `travelData`
  `MovePath` should be at the deepest depth we want to get.
  `filterResults` is array of list attributes. Each attribute will be wrapped into `ResultGetter` object with

  - `name`: The new name of attribute
  - `path`: array from accessor to current attribute.
    `[parent of parent..., parent, current]`
  - `fnGet`: customize function which will transform current value to desired value. Default value is `_fnGetDefault = (a) => a;`

```js
const schema = travelSchema(objTree);
const data = travelData(
  objTree,
  schema,
  MovePath.parse("A.E.E1", ".")
).filterResults([ResultGetter.parse("A.E.E1", "A.E.E1", ".")]);
```

- Option 2: shortcut of Option 1.
  `Traveller` instance will travel with the longest path provided (in array of paths which will convert to `ResultGetter` objects).

```js
const objTree = {
  A: {
    B: "A String",
    C: 123,
    D: {
      D1: "D1 String",
      D2: "D2 String",
    },
    E: [
      {
        E1: "E1 in element 1",
        E12: [
          {
            E121: "E121 Value (0)",
            E122: "E122 Value (0)",
            E123: "E123 have value",
          },

          {
            E121: "E121 Value (1)",
            E122: "E122 Value (1)",
            // E123: "E123 have value",
          },
        ],
      },
      {
        E1: "E1 in element 2",
      },
    ],
  },
};

const { data } = traveller.go(objTree, [
  { name: "A.E.E1", path: ["A", "E", "E1"], fnGet: (x) => x },
  { name: "A.C", path: ["A", "C"], fnGet: (x) => x },
]);
```

## Licence

- Licensed under MIT
- Copyright (c) 2024 HoHai

If you find it useful, you can buy me a cup of coffee: https://www.buymeacoffee.com/hohai
