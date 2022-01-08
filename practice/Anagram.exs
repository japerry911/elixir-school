defmodule Anagram do
  def anagram?(a, b) when byte_size(a) !== byte_size(b), do: false
  def anagram?(a, b) when byte_size(a) == byte_size(b) do
    Map.equal?(create_char_map(String.downcase(a)), create_char_map(String.downcase(b)))
  end

  defp create_char_map(s) when is_bitstring(s) do
    s
    |> String.graphemes()
    |> Enum.reduce(Map.new(), fn c, acc -> Map.update(acc, c, 1, &(&1 + 1)) end)
  end
end

# IO.inspect(Anagram.anagram?("abc", "cb"))
# # false

IO.inspect(Anagram.anagram?("abc", "cba"))
# true
