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
draft = false // true for draft version
+++
```

- Publish into `Github`. The `Github Action workflow` will automatic build and publish the page

```
git push
```

- Others: Refer to Hugo/Congo docs:
  - https://jpanther.github.io/congo/docs/
  - https://jpanther.github.io/congo/docs/hosting-deployment/
  - https://jpanther.github.io/congo/samples/
