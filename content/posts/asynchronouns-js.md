+++
title = 'Asynchoronous Javascript'
date = 2023-12-05T07:07:07+01:00
+++

## Asynchoronous Javascript

Follow the link:

- https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Asynchronous/Introducing

### Callback hell

- How to notify the caller when the nest function is complete >> We use a callback function.
- But in the case if we compose the sequenced steps (one by one), then we got deeply nested `doOperation()` >> this is `Callback hell`

```javascript
function doStep1(init, callback) {
  const result = init + 1;
  callback(result);
}

function doStep2(init, callback) {
  const result = init + 2;
  callback(result);
}

function doStep3(init, callback) {
  const result = init + 3;
  callback(result);
}

function doOperation() {
  doStep1(0, (result1) => {
    doStep2(result1, (result2) => {
      doStep3(result2, (result3) => {
        console.log(`result: ${result3}`);
      });
    });
  });
}

doOperation();
```

### `Promise` is solution for Callback hell

- `Promise` is an object returned by `asynchronous function` represent the current state of the operation
  - At the time calling: return the `caller` a `promise` object which provides methods to handle eventual success or failure of the operation
- State of a `promise`:
  - `pending`: the promise has been created, and the asynchronous function it's associated with has not succeeded or failed yet. This is the state your promise is in when it's returned from a call to fetch(), and the request is still being made.
  - `fulfilled`: the asynchronous function has succeeded. When a promise is fulfilled, its then() handler is called.
  - `rejected`: the asynchronous function has failed. When a promise is rejected, its catch() handler is called.

![](./imgs/async-js.png)

### Create manual Promise object

- We can create a `Promise` object by class instance. The contructor is the function handler that accept 2 parameters (funcResolve, funcReject) which are other functions to notify in the 2 cases: 'fulfilled' or 'rejected'.

```javascript
const aPromise = new Promise((funcResolve, funcReject) => {
  // The operation may be take long time.
  // I try to simulate by mark the promise is "fulfilled" after 5s
  setTimeout(() => funcResolve("Done"), 5000);

  // In the case if we want to mark the promise is "rejected" then
  // funcReject('SomeReason')
});
```

### Use Promise in `fetch`

```javascript
// create new Promise object
const fetchPromise = fetch(
  "https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/products.json"
);

// Immediate return the state with 'pending'. When complete the state will change to 'fulfiled' or 'rejected'
console.log(fetchPromise);

// In the case success, then execute the function handler in then...(may be take long time to trigger this)
fetchPromise.then((response) => {
  console.log(`Received response: ${response.status}`);
});

console.log("Started request…");
```

### Chaining Promises

- `promise.then` will return other `promise` object, we can use to compose the chain promise

```javascript
promise1.then(success_func1_with_returned_promise_2)
        .then(success_func2_with_returned_promise_3)...
        .then(success_funcN)
        .catch(error_handle1)
```

- Example:

```javascript
const fetchPromise = fetch(
  "bad-scheme://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/products.json"
);

fetchPromise
  .then((response) => {
    if (!response.ok) {
      throw new Error(`HTTP error: ${response.status}`);
    }
    return response.json();
  })
  .then((data) => {
    console.log(data[0].name);
  })
  .catch((error) => {
    console.error(`Could not get products: ${error}`);
  });
```

### Combining multiple promises

- `Promise.all`

  - `Fulfilled` if ALL promises in the array are `fulfilled` (success)
  - `Rejected` if ANY promises in the array are `Rejected`

    ```javascript
    const fetchPromise1 = fetch(
      "https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/products.json"
    );
    const fetchPromise2 = fetch(
      "https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/not-found"
    );
    const fetchPromise3 = fetch(
      "https://mdn.github.io/learning-area/javascript/oojs/json/superheroes.json"
    );

    Promise.all([fetchPromise1, fetchPromise2, fetchPromise3])
      .then((responses) => {
        for (const response of responses) {
          console.log(`${response.url}: ${response.status}`);
        }
      })
      .catch((error) => {
        console.error(`Failed to fetch: ${error}`);
      });
    ```

    All of promises will be `Fulfilled` although the second request will return the 404 error

    ```
    https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/products.json: 200
    https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/not-found: 404
    https://mdn.github.io/learning-area/javascript/oojs/json/superheroes.json: 200
    ```

- `Promise.any`: Reverse of `Promise.all`

### Async and Await

- Provide a simpler way to work with asynchronous promise-based code.
- Not replace `promise` approach.
- Inside `async function`, you can use `await` keyword before a call which returned a `promise`. This make code wait until the promise is settled (`fulfilled` or `rejected`)
- Return of `async function` **ALLWAY IS a PROMISE** object. Then we can attach the
  fulfilled function in `then`, and rejected function in `catch`

```javascript
// Here is a promise object
const fetchPromise = fetch(
  "https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/products.json"
);

// Here is response object (resule of fulfilled promise) with await keyword
const response = await fetch(
  "https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/products.json"
);
```

```javascript
async function fetchProducts() {
  try {
    const response = await fetch(
      "https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/products.json"
    );
    if (!response.ok) {
      throw new Error(`HTTP error: ${response.status}`);
    }
    const data = await response.json();
    return data;
  } catch (error) {
    console.error(`Could not get products: ${error}`);
  }
}

const promise = fetchProducts();
promise.then((data) => console.log(data[0].name));
```
