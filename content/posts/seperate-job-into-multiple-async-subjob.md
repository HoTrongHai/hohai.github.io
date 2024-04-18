+++
title = 'Seperate a job into multiple async jobs'
date = 2024-04-01
+++

# Seperate a job into multiple async jobs

Sometime when I make a rquest to get info from an API which do some specified task per request.
Then job will take longtime to run if I have muliple requests.

```js
for (let i = 0; i < count; i++) {
  const responsePerRequest = request("Some data of i", i);
}
```

- Total time = `Total(responsePerRequest)`
  Because of each request `i` is independence, then I can split these request into a jobs then call `async`

### Make a job executes a list of request

```js
async function childJob(subSetOfRequests) {
  // We can do sequencely subset of requests by synchoronous
  // For example in the case we make request to API using `axios` then we can do by

  for (let i = 0; i < subSetOfRequests.length; i++) {
    const response = await axios.post(
      `URL for request ${i}`,
      body_for_post_only,
      {
        params_or_headers,
      }
    );
  }
}
```

### Split request into list of subset requests

```js
function chunkArray(requests, chunkSize) {
  const listOfSubsets = [];

  for (let i = 0; i < requests.length; i++) {
    listOfSubset.push(requests.slice(i, i + chunkSize));
  }

  return listOfSubsets;
}
```

### Execute in main job

```js
async function mainJob(requests) {
  const listOfSubsets = chunkArray(requests, 3); // Chunk size = 3 for example

  // For each subset of requests, we can make async child job to run.
  // Using map built-in of array to transform a subset into a child job
  const promises = listOfSubsets.map((subset) => childJob(subset));

  // Await all of child jobs to complete by using Promise.all and await
  const results = await Promise.all(promises);
}
```
