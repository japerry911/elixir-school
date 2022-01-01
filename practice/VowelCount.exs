defmodule VowelCount do
  @vowels ["a", "e", "i", "o", "u"]

  def get_count(str) do
    String.split(str, "")
    |> Enum.filter(&(Enum.member?(@vowels, &1)))
    |> length
  end
end

IO.inspect VowelCount.get_count("abracadabra")
# 5
