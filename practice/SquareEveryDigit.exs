defmodule SquareEveryDigit do
  def square_digits(n) do
    Integer.digits(n)
    |> Enum.map(&(trunc(:math.pow(&1, 2))))
    |> Enum.join
    |> String.to_integer
  end
end

IO.inspect SquareEveryDigit.square_digits(9119)
# 811181
