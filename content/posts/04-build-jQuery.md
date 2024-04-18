### Use function contructor then we can access the `prototype` as `__proto__` object

```js
// Use function contructor then we can access the `prototype` as `__proto__` object

function Empty() {}

var jQuery = new Empty();

(function () {
  var slice = [].slice;

  jQuery.fn = jQuery.__proto__ = {
    toArray: function () {
      return slice.call(this);
    },
  };
})();

console.log(jQuery.toArray([1, 2, 3]));
```
