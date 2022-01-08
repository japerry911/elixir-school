defmodule RemoveDuplicates do
  def solve(list, previous_values \\ nil)
  def solve([], _previous_values), do: []
  def solve(list, previous_values) when is_nil(previous_values), do: solve(Enum.reverse(list), [])
  def solve([head | tail], []), do: Enum.reverse([head | solve(tail, [head])])
  def solve([head | tail], previous_values) do
    if exists_in_list?(previous_values, head) == true do
      solve(tail, previous_values)
    else
      [head | solve(tail, [head | previous_values])]
    end
  end

  defp exists_in_list?(list, value), do: value in list
end


# IO.inspect(RemoveDuplicates.solve([3,4,4,3,6,3]))
# # [4, 6, 3]

IO.inspect(RemoveDuplicates.solve([1, 2, 1, 2, 1, 2, 3]))
# [1, 2, 3]
