+++
title = 'React useContext'
date = 2024-01-17
+++

## Use context

### Basic usage

- Provider: We can export the `context` object for other module can reuse

  ```javascript
  const JiraActionContext = createContext();

  export default function JiraTrackingByDate() {
  return;
  <JiraActionContext.Provider
      value={onJiraCellChange}
          {...}
  ></JiraActionContext.Provider>;
  }
  ```

- Consumer:

  - We can import the `context` object then can use

    ```javascript
    import { JiraActionContext } from "./JiraTrackingByDate";

    function JiraEditableTextField({ jiraRow, jiraField, jiraDate, children }) {
    const onJiraCellChange = useContext(JiraActionContext);
    ```

### Advanced usage

We will implement `Provider` function at a children.

- **Steps**:

  - Seperate logic of `createContext()` at other file to easily manage the import dependency
    We create an **object** wrapping `{data, setData}`
  - The `Consumer` will attract only the `{data}` property and usage it
  - The `Provider` will attract `{setData}`

- **Sample reference:**
  https://stackoverflow.com/questions/50502664/how-to-update-the-context-value-in-a-provider-from-the-consumer

![Alt text](./imgs/use-context.png)

- the `authContext` will be seperated in other file `authContext.js`

```js
import { createContext } from "react";

const authContext = createContext({
  authenticated: false,
  setAuthenticated: (auth) => {},
});

export default authContext;
```

- The `Consumer` (`Login.js` in this case):

```js
import React, { useContext } from "react";
import authContext from "./authContext";

export default () => {
  const { setAuthenticated } = useContext(authContext);
  const handleLogin = () => setAuthenticated(true);
  const handleLogout = () => setAuthenticated(false);

  return (
    <React.Fragment>
      <button onClick={handleLogin}>login</button>
      <button onClick={handleLogout}>logout</button>
    </React.Fragment>
  );
};
```

- The `Provider`

  ```js
  import ReactDOM from "react-dom";
  import React, { useState } from "react";

  import authContext from "./authContext";
  import Login from "./Login";

  const App = () => {
    const [authenticated, setAuthenticated] = useState(false);

    return (
      <authContext.Provider value={{ authenticated, setAuthenticated }}>
        <div> user is {`${authenticated ? "" : "not"} authenticated`} </div>
        <Login />
      </authContext.Provider>
    );
  };

  ReactDOM.render(<App />, document.getElementById("container"));
  ```
