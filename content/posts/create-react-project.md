+++
title = 'Create React project'
date = 2023-10-30
+++

### Create React project

- Create `React` + `Vite` project by the following command

```shell
npm create vite@latest
```

Then follw the prompts.
Refer to: https://vitejs.dev/guide/

- Create `React` only:

```shell
npx create-react-app <APP-NAME>
```

Refer to: https://create-react-app.dev/

### Install required packages

We can install required packages by using `npm`

```shell
npm install <PACKAGE-NAME>
```

- Install Chakra UI packages: https://chakra-ui.com/getting-started

  ```shell
  npm i @chakra-ui/react @emotion/react @emotion/styled framer-motion
  # For use Chakra UI icon
  npm i @chakra-ui/icons
  ```

The information of installed packages will be keep in `package.json`:

```json
  "dependencies": {
   "@chakra-ui/icons": "^2.1.1",
   "@chakra-ui/react": "^2.8.1",
   "@emotion/react": "^11.11.1",
   "@emotion/styled": "^11.11.0",
   "@vitejs/plugin-react-swc": "^3.3.2",
   "axios": "^1.6.2",
   "framer-motion": "^10.16.4",
   "get-input-selection": "^1.1.4",
   "lodash.isequal": "^4.5.0",
   "prop-types": "^15.8.1",
   "react": "^18.2.0",
   "react-autocomplete-input": "^1.0.29",
   "react-dom": "^18.2.0",
   "react-full-screen": "^1.1.1",
   "react-router-dom": "^6.18.0",
   "textarea-caret": "^3.1.0",
   "vite": "^4.4.5"
 },
 "devDependencies": {
   "@types/react": "^18.2.15",
   "@types/react-dom": "^18.2.7",
   "@vitejs/plugin-react-swc": "^3.3.2",
   "eslint": "^8.45.0",
   "eslint-plugin-react": "^7.32.2",
   "eslint-plugin-react-hooks": "^4.6.0",
   "eslint-plugin-react-refresh": "^0.4.3",
   "vite": "^4.4.5"
 }

```
