---
title: "Welcome to my blogs! :tada:"
description: "This is my blog of technical, programming and more..."
---

{{< lead >}}
This is my blog of technical, programming and more...
{{< /lead >}}

### Create a post from markdown

- Put markdown under the folder `content/posts`.
- Append the meta data in the markdown (if doesn't have):

```
+++
title = 'Title Name'
date = 2023-12-12
+++
```

Or if we want to keep `Draft` version

```
+++
title = 'Title Name'
date = 2023-12-12
draft = true
+++
```

- The images will be allocated at `../../assets/img/`
- Draw diagram using `mermaid`:

```
{{< mermaid >}}

flowchart
A["Variable Environment"]
B["this"]
C["Outer Environment"]
D["this will be changed depend on how function is call"]

subgraph Execution Context is create
direction TB
A
B
C
D-->B
end

style D fill:none

{{< /mermaid >}}
```

- Run on local.

```
hugo server -D
```

- Publish into `Github`. The `Github Action workflow` will automatic build and publish the page

```
git add .
git commit -m "Update"
git push
```

- Others: Refer to Hugo/Congo docs:
  - https://jpanther.github.io/congo/docs/
  - https://jpanther.github.io/congo/docs/shortcodes/
  - https://jpanther.github.io/congo/docs/hosting-deployment/
  - https://jpanther.github.io/congo/samples/

### TODO List

- [ ] Write `Deep Dive in React Query` {{< badge >}}Before 21-Apr{{< /badge >}}
- [ ] Study `React Admin` {{< badge >}}Before 02-May{{< /badge >}}
