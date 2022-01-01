- Elixir offers various functions to access and generate docuentation for projects
- examples of annotation
  - `#` for inline documentation
  - `@moduledoc` for module-level documentation
  - `@doc` - for function-level documentation
- documenting modules example
  - sits below `defmodule`
  ```elixir
  defmodule Greeter do
    @moduledoc """
    Provides a function `hello/1` to greet a human
    """
  end
  ```
- documenting functions example

  - sits above `def` method

  ```elixir
  defmodule Greeter do
  @moduledoc """
    ...
    """

    @doc """
    Prints a hello message.

    ## Parameters

      - name: String that represents the name of the person.

    ## Examples

        iex> Greeter.hello("Sean")
        "Hello, Sean"

        iex> Greeter.hello("pete")
        "Hello, pete"

    """
    @spec hello(String.t()) :: String.t()
    def hello(name) do
      "Hello, " <> name
    end
  end
  ```

- ExDoc
  - documentation generator tool for Elixir
  - set-up
    - dependency
      - `{:ex_doc, "~> 0.21", only: :dev, runtime: false}`
        - only `:dev` because don't want to download `ex_doc` dependency in a production environment
      - `mix deps.get`
      - `mix docs`
        - makes the documentation
