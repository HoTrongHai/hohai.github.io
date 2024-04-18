+++
title = 'Setup Javascript'
date = 2023-11-03
+++

### Debug

If you have error such as `Error [ERR_MODULE_NOT_FOUND]: Cannot find module` () https://stackoverflow.com/questions/65384754/error-err-module-not-found-cannot-find-module) then you can check the import in javascript

```javascript
// Should include .js as fullname of module
import { SnapshotData, TagQueryShapshotMerger } from "./RemoteData.js";
```
