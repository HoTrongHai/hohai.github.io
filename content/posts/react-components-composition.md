+++
title = 'React Components Composition'
date = 2023-12-05
+++

## React Components Composition

Refer to link: https://www.developerway.com/posts/components-composition-how-to-get-it-righ

### Simple components

- Accept `props`
- Have some states

```jsx
const Button = ({ title, onClick }) => (
  <button onClick={onClick}>{title}</button>
);
```

### Composition components

- Can compose new component from other components

```jsx
const Navigation = () => {
  return (
    <>
      // Rendering out Button component in Navigation component. Composition!
      <Button title="Create" onClick={onClickHandler} />
      ... // some other navigation code
    </>
  );
};
```

### Container components

- Allow passing specical prop `children`

```jsx
// the code is exactly the same! just replace "title" with "children"
const Button = ({ children, onClick }) => (
  <button onClick={onClick}>{children}</button>
);

const Navigation = () => {
  return (
    <>
      <Button onClick={onClickHandler}>Everything here can be rendered</Button>
      ... // some other navigation code
    </>
  );
};
```

- Example, we can create the collapsable component wrapping other component with supporting collapsing

```jsx
const CollapsableSection = ({ children, title }) => {
  const [isCollapsed, setIsCollapsed] = useState(false);

  return (
    <div className="sidebar-section">
      <div
        className="sidebar-section-title"
        onClick={() => setIsCollapsed(!isCollapsed)}
      >
        {title}
      </div>

      {!isCollapsed && <>{children}</>}
    </div>
  );
};
```
