+++
title = 'React Custom Hooks'
date = 2023-12-07
+++

## React Custom Hook

Follow the link:
https://blog.logrocket.com/developing-responsive-layouts-with-react-hooks/

- Create the new custom hook to:
  - Any event `resize` change will trigger rendering new components (<MobileComponent> or <DesktopComponent>)
  - The logic:
    `resize` event >> setWind (thanks to `useEffect` hook and event listener) >> width changed >> re-evaluate `width < breakpoint ` >> new component render

```jsx
const useViewport = () => {
  // Declare a new state variable with the "useState" Hook
  const [width, setWidth] = React.useState(window.innerWidth);

  React.useEffect(() => {
    /* Inside of a "useEffect" hook add an event listener that updates
       the "width" state variable when the window size changes */

    const handleWindowResize = () => setWidth(window.innerWidth);
    window.addEventListener("resize", handleWindowResize);
    return () => window.removeEventListener("resize", handleWindowResize);

    /* passing an empty array as the dependencies of the effect will cause this
       effect to only run when the component mounts, and not each time it updates.
       We only want the listener to be added once */
  }, []);

  // Return the width so we can use it in our components
  return { width };
};

const MyComponent = () => {
  const { width } = useViewport();
  const breakpoint = 620;

  return width < breakpoint ? <MobileComponent /> : <DesktopComponent />;
};
```

- Optimizing performance with a Context
  - Wrap `chidren` with the `viewportContext.Provider`
  - Rewrite `useViewPort` using value of `viewportContext` object

```javascript
const viewportContext = React.createContext({});

const ViewportProvider = ({ children }) => {
  // This is the exact same logic that we previously had in our hook

  const [width, setWidth] = React.useState(window.innerWidth);
  const [height, setHeight] = React.useState(window.innerHeight);

  const handleWindowResize = () => {
    setWidth(window.innerWidth);
    setHeight(window.innerHeight);
  };

  React.useEffect(() => {
    window.addEventListener("resize", handleWindowResize);
    return () => window.removeEventListener("resize", handleWindowResize);
  }, []);

  /* Now we are dealing with a context instead of a Hook, so instead
     of returning the width and height we store the values in the
     value of the Provider */
  return (
    <viewportContext.Provider value={{ width, height }}>
      {children}
    </viewportContext.Provider>
  );
};

/* Rewrite the "useViewport" hook to pull the width and height values
   out of the context instead of calculating them itself */
const useViewport = () => {
  /* We can use the "useContext" Hook to acccess a context from within
     another Hook, remember, Hooks are composable! */
  const { width, height } = React.useContext(viewportContext);
  return { width, height };
};

/* Make sure you also wrap the root of your application in the new ViewportProvider, so that the newly rewritten useViewport Hook will have access to the Context when used further down in the component tree. */

const App = () => {
  return (
    <ViewportProvider>
      <AppComponent />
    </ViewportProvider>
  );
};

const MyComponent = () => {
  const { width } = useViewport();
  const breakpoint = 620;

  return width < breakpoint ? <MobileComponent /> : <DesktopComponent />;
};
```
