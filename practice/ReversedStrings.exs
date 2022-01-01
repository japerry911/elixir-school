defmodule ReversedStrings do
  def reverse(string) do
    String.split(string, "")
    |> Enum.filter(&(&1 != ""))
    |> Enum.reverse
    |> List.to_string
  end
end

IO.inspect ReversedStrings.reverse("world")
# "dlrow"
