+++
title = 'Server handle exception and result'
date = 2023-11-30
+++

## Server handle exception and result

One problem when we process requests from client is:

- What is format of result of response
- What is exception policy should be handle. For example, if client sent the bad request (bad query) then what is message response that server
  need to notify to client ?
  For above reasons, I will introdure 2 modules: - `_input_boundary.py`: the module will handle in request and wrap response to `flask.Response` with json format - `flask_api_handle.py`: the module will hook to handle when exception occurs

### Input output boundrary

Because I want to send all of data in body (not in query parameters)
then I will to expose `POST` method to client. For the request to JIRA server, we use `GET` method

> Client (Send **POST**) >> Backend (Flask API - Receive **POST**, Send **GET**) >> JIRA Server (REST - Receive **GET**)

- Client send in Javascript:

  ```javascript
  async function _postRequest(url, data, onSuccess, onFailure) {
    // We can remove await to run parallel
    await axios
      .post(url, data, {
        headers: {
          "Content-type": "application/json",
          Accept: "application/json",
        },
      })
      .then((response) => {
        // console.log(response);
        onSuccess(response);
      })
      .catch((error) => {
        console.log(error);

        const message =
          (error.response && error.response.data) || error.message;
        // (error.response && error.response.data["message"]) || error.message;
        const urlConfig =
          "config" in error && "url" in error.config && error.config.url;
        onFailure(message + ":" + urlConfig);
      });
  }
  ```

- Backend Flask API:
  - Parse information in body json request (`parse_from_request`)
  - Forward to Rest Jira API server to process
  - Parse the response and wrap with tuple of (code, data). The data will be transformed to json object

### Server handle exception

For above reasons, I want to make sure all of exception when be catched and re-direct to client to show up
which detail error that server got (This one may be reveal some issue of security, we can use
some other policy like log/notify...).

- To do that I will create a decorator wrapping all of functions with `try..catch` to make sure all of exception will be
  catch and transform to `ServerException` instance.

  ```python
  def with_server_error_handle(f):
      # We need to overwrite the name, because if keep default name ("_wrap_") then
      # in the view functions will have duplication URL mapping when we have more than 1 APIs
      @wraps(f)
      def _wrap_(*args, **kwargs):

          try:
              data = f(*args, **kwargs)
              return data
          except Exception as e:
              if isinstance(e, ServerException):
                  raise e
              else:
                  raise ServerException(e.code if hasattr(e, 'code') else 500, str(e))

  ```

  - There are 2 points:
    - Why we need to `@wrap` decorator: The `@wrap` will be copy all of attribute of old function (f)
      into the new wrapped function. The copied attributes are: **doc**, **name**...
      The **name** is new name of function. If we don't copy this one, may be if we have 2 functions then
      they will be duplicate in Flask App route table (mapping routes with functions).
    - Why we need to check `if isinstance(e, ServerException):` in exception.
      In the case we have nest function like this:
      ```python
      f1(f2(some_exception_may_be_throw))
      ```
      In the `f2` may be we got the an exception, then we create new `ServerException` to pack this information.
      the exception will be raise to `f1`. In `f1` the server exception will be catched. If we not raise this
      server exception, then we need create to new one. This process will be remove usefull information.
      After we have the method

- Register customize `ServerException` in Flask app:
  ```python
  def register_handle_server_exception(app: Flask, handle_func=handle_server_exception):
      """
      Register handler function without using decorator.
      """
      app.register_error_handler(ServerException, handle_func)
  ```
