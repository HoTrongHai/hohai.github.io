+++
title = 'React Query'
date = 2024-04-18
draft = true
+++

### Reference

### Global state

- Avoid prop drilling
- Access data accoss our application without copying

{{< mermaid >}}
flowchart
A["PostsContext()"]
B["posts state: [posts, setPosts]"]
C["status state: [status, setStatus]"]
D["PostsContext()"]
E["refetch function hook"]

A--create-->B
C--refer-->B
D--refer-->B
{{< /mermaid >}}

### Global components: Not remove dedup requests

```js
export function PostsContext({ children }) {
  // Every time call `PostsContext` function, we will create bellow objects
  const [posts, setPosts] = React.useState([]);
  const [error, setError] = React.useState();
  const [status, setStatus] = React.useState("loading");

  const refetch = async () => {
    try {
      setStatus("loading");
      const posts = await axios.get("/api/posts").then((res) => res.data);
      setPosts(posts);
      setStatus("success");
    } catch (err) {
      setstatus("error");
      setError(err);
    }
  };

  const contextValue = React.useMemo(() => ({
    posts,
    status,
    error,
    refetch,
  }));

  return <context.Provider value={contextValue}>{children}</context.Provider>;
}
```

- Consumer

```js
export default usePosts() {

    const {posts, status, error, refetch} = React.useContext(context);

    // Every component use `usePosts` then `refetch` will be called at mounting time
    // Not remove dedup requesting
    React.useEffect(() => {
        refetch()
    }, []);

    return {
        posts,
        status,
        error,
        refetch,
    }

}

```

### Fix dedup requests

```js
export function PostsContext({ children }) {
  // Every time call `PostsContext` function, we will create bellow objects
  const [posts, setPosts] = React.useState([]);
  const [error, setError] = React.useState();
  const [status, setStatus] = React.useState("loading");

  // Add new ref object which cannot reset between re-rendering
  const activePromiseRef = React.useRef(false);

 // Stick `refetch` function with a new ref object
 // If any other requests that happen while the promise is still pending we will reuse the promise from the original request
  const refetch = () => {
    if (!activePromiseRef.current) {
      activePromiseRef.current = async () => {
        try {
          setStatus("loading");
          const posts = await axios.get("/api/posts").then((res) => res.data);
          setPosts(posts);
        } catch (err) {
          setStatus("error");
          setError(err);
        }
        finally {
            activePromiseRef.current = false;
        }
      }(); // Execute immediately
    }

    // If any other requests that happen while the promise is still pending we will reuse the promise from the original request (we don't fire extra one)
    return activePromiseRef.current;
  };



  const contextValue = React.useMemo(() => ({
    posts,
    status,
    error,
    refetch,
  }));

  return <context.Provider value={contextValue}>{children}</context.Provider>;
}
```
