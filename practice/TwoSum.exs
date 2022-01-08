defmodule TwoSum do
  def two_sum(numbers, target, current \\ -1, found \\ nil, offset \\ 1)
  def two_sum(_numbers, _target, current, found, _offset) when is_integer(found), do: {current, found}
  def two_sum([head | tail], target, current, found, offset)  when is_nil(found) do
    case Enum.find_index(tail, &(&1 == number_needed(head, target))) do
      nil -> two_sum(tail, target, current + 1, nil, offset + 1)
      x -> two_sum(tail, target, current + 1, x + offset, offset + 1)
    end
  end

  defp number_needed(number, target), do: target - number
end

# IO.inspect(TwoSum.two_sum([1, 2, 3], 4))
# # In [{0, 2}, {2, 0}]

IO.inspect(TwoSum.two_sum([1234, 5678, 9012], 14690))
# In [{1, 2}, {2, 1}]
