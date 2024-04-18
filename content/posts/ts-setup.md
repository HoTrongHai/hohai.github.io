+++
title = 'TypeScript Setup'
date = 2023-11-03
+++

## Typescript setup

- Install `node.js`
- Install `typescript` package using `npm`

```shell
npm install typescript
```

### Run on node the first ts

- Write a file name `example.ts` with extenstion `.ts`

```typescript
type WithName = {
  name: string;
};

function printName(arg: WithName) {
  console.log(arg.name);
}

printName({
  name: "HoHai",
});
```

- Compile `ts` >> `js`

```shell
tsc example.ts
```

- Run the compiled js file

```shell
node first.js
```

### Run on browser

- Create new html file, for example `index.html`

  - In VS Code type `!` to suggest the content of html file

  - In `<body>` tag put the `<script>` tag with `src` attribute refer to file javascript file

  ```html
  <!DOCTYPE html>
  <html lang="en">
    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=<device-width>, initial-scale=1.0" />
      <title>Document</title>
    </head>
    <body>
      <script src="example.js"></script>
    </body>
  </html>
  ```

- Open the `index.html` in browser

### Combine both of `compile` and `run node` on single step

- Install `ts-node` package

```shell
npm install ts-node
```

- Run typescript file using command (NOT RECOMMEND)
  - If we got the error "ERR_UNKNOWN_FILE_EXTENSION" then we can remove "type": "module" from package.json.
    But IMPORTANT, if we remove the option `"type": "module"` then we got the debug error

```shell
ts-node example.ts
```

### Compiler Options

- Init the typescript config (`tsconfig.json`)

```shell
tsc --init
```

- Some common options:
  - `rootDir`: input folder typescript source files
  - `outDir`: output folder javascript compiled files
  - `target`: compile output javascript version
  - `sourceMap`: `true` for debugging typescript

### Debugging TypeScript

Refer to: https://code.visualstudio.com/docs/typescript/typescript-debugging

- In `tsconfig.json` enable `sourceMap` setting:

```json
{
  "compilerOptions": {
    "target": "ES5",
    "module": "CommonJS",
    "outDir": "out",
    "sourceMap": true
  }
}
```

- Create run mode on VSCode `launch.json`:
  - Press con `Run/Debug` or `Ctr+Shift+D`
  - Setup the values:
  ```json
   "skipFiles": ["<node_internals>/**"],
    "program": "${workspaceFolder}/js-jsx/example.ts", // Program to run
    "preLaunchTask": "tsc: build - js-jsx/tsconfig.json", // Need to compile typescript first
    "outFiles": ["${workspaceFolder}/out/**/*.js"] // Lookup compiled javascript files
  ```
