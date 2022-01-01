- modules allow us to organize functions into a namespace
- module attributes

  - used as constants usually
  - example

    ```elixir
      defmodule Example do
        @greeting "Hello"

        def greeting(name) do
          ~s(#{@greeting} #{name}.)
        end
    ```

- structs
  - special maps with a defined set of keys and default values
  - must be defined within a module
  - example
  ```elixir
    defmodule Example.User do
      defstruct name: "Skylord", roles: []
  ```
