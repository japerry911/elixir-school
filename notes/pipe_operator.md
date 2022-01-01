- pipe operator
  - `|>`
  - takes the result of one expression, and passes it on
  - example
    - without pipe operator
      - `foo(bar(baz(new_function(other_function()))))`
    - with pipe operator
      - `other_function() |> new_function() |> baz() |> bar() |> foo()`
  - when arity of function is greater than 1, then use parenthesis around argument(s)