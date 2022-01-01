defmodule DescendingOrder do
  def descending_order(n) do
    Integer.digits(n)
    |> Enum.sort(&(&1 >= &2))
    |> Integer.undigits
  end
end


IO.inspect DescendingOrder.descending_order(42145)
