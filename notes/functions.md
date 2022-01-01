- anonymous functions
  - no name
  - example
  - `sum = fn (a, b) -> a + b end`
    - equivalent to:
      - `sum = &(&1 + &2)`
- named functions
  - example
    ```elixir
      def hello(name) do
        "Hello, " <> name
      end
    ```
    - if function body spans only one line, can be shortened to:
      ```elixir
        def hello(name), do: "Hello, " <> name
      ```
- private functions
  - can't accessit unless within module
  - example
    ```elixir
      defmodule Greeter do
        def hello(name), do: phrase() <> name
        defp phrase, do: "Hello, "
      end
    ```
- guards

  - `when`

    - determine which signature to use based on the arguments type example

      ```elixir
        def hello(names) when is_list(names) do...
        end

        def hello(name) when is_binary(name) do...
        end
      ```

- default arguments
  - `argument \\ value` syntax
  - example
    ```elixir
      def hello(name \\ "Skylord") do...
      end
    ```
