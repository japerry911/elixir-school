A list of available sigils include:

- ~C Generates a character list with no escaping or interpolation
- ~c Generates a character list with escaping and interpolation
- ~R Generates a regular expression with no escaping or interpolation
- ~r Generates a regular expression with escaping and interpolation
- ~S Generates a string with no escaping or interpolation
- ~s Generates a string with escaping and interpolation
- ~W Generates a word list with no escaping or interpolation
- ~w Generates a word list with escaping and interpolation
- ~N Generates a NaiveDateTime struct
- ~U Generates a DateTime struct (since Elixir 1.9.0)

- note: avoid creating `NaiveDateTime`

- can create own sigils
  - example
  ```elixir
    defmodule MySigils do
      def sigil_p(string, []), do: String.upcase(string)
    end
  ```
  - the function definition of custom sigil must take 2 arguments
    1. an input
    2. <b>a list</b>
