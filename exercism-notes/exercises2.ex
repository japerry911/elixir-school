defmodule Lasagna do
  # Please define the 'expected_minutes_in_oven/0' function
  def expected_minutes_in_oven() do
    40
  end
  # Please define the 'remaining_minutes_in_oven/1' function
  def remaining_minutes_in_oven(elapsed_time) do
    expected_minutes_in_oven() - elapsed_time
  end
  # Please define the 'preparation_time_in_minutes/1' function
  def preparation_time_in_minutes(layers) do
    layers * 2
  end
  # Please define the 'total_time_in_minutes/2' function
  def total_time_in_minutes(layers, elapsed_time) do
    preparation_time_in_minutes(layers) + elapsed_time
  end
  # Please define the 'alarm/0' function
  def alarm() do
    "Ding!"
  end
end


defmodule Rules do
  def eat_ghost?(power_pellet_active, touching_ghost) do
    power_pellet_active and touching_ghost
  end

  def score?(touching_power_pellet, touching_dot) do
    touching_power_pellet or touching_dot
  end

  def lose?(power_pellet_active, touching_ghost) do
    not power_pellet_active and touching_ghost
  end

  def win?(has_eaten_all_dots, power_pellet_active, touching_ghost) do
    has_eaten_all_dots and not lose?(power_pellet_active, touching_ghost)
  end
end


defmodule Secrets do
  def secret_add(secret) do
    fn param -> param + secret end
  end

  def secret_subtract(secret) do
    fn param -> param - secret end
  end

  def secret_multiply(secret) do
    fn param -> param * secret end
  end

  def secret_divide(secret) do
    fn param -> div(param, secret) end
  end

  def secret_and(secret) do
    fn param -> Bitwise.&&&(param, secret) end
  end

  def secret_xor(secret) do
    fn param -> Bitwise.^^^(param, secret) end
  end

  def secret_combine(secret_function1, secret_function2) do
    fn param -> secret_function2.(secret_function1.(param)) end
  end
end


defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount - (before_discount * (discount / 100))
  end

  def monthly_rate(hourly_rate, discount) do
    trunc(Float.ceil(apply_discount(daily_rate(hourly_rate), discount) * 22))
  end

  def days_in_budget(budget, hourly_rate, discount) do
    Float.floor(budget / (apply_discount(daily_rate(hourly_rate), discount)), 1)
  end
end


defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove(list) do
    tl(list)
  end

  def first(list) do
    hd(list)
  end

  def count(list) do
    length(list)
  end

  def functional_list?(list) do
    Enum.member?(list, "Elixir")
  end
end


defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level === 0 and not legacy? -> :trace
      level === 1 -> :debug
      level === 2 -> :info
      level === 3 -> :warning
      level === 4 -> :error
      level === 5 and not legacy? -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    cond do
      to_label(level, legacy?) in [:error, :fatal] -> :ops
      to_label(level, legacy?) === :unknown and legacy? -> :dev1
      to_label(level, legacy?) === :unknown and not legacy? -> :dev2
      true -> false
    end
  end
end


defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    cond do
      abs(x) <= 0.7 and abs(y) <= 1 -> 10
      abs(x) !== 3.6 and abs(x) <= 5 and abs(y) <= 5 -> 5
      abs(x) <= 7 and abs(y) <= 10 -> 1
      true -> 0
    end
  end
end


defmodule GuessingGame do
  def compare(sn, guess \\ :no_guess)
  def compare(_sn, guess) when guess === :no_guess do
    "Make a guess"
  end
  def compare(sn, guess) when guess === sn do
    "Correct"
  end
  def compare(sn, guess) when guess === sn - 1 or guess === sn + 1 do
    "So close"
  end
  def compare(sn, guess) when guess > sn do
    "Too high"
  end
  def compare(sn, guess) when guess < sn do
    "Too low"
  end
end


defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    cond do
      divisible_by_4?(year) and divisible_by_400?(year) -> true
      divisible_by_4?(year) and divisible_by_100?(year) and divisible_by_400?(year) -> true
      divisible_by_4?(year) and not divisible_by_100?(year) -> true
      true -> false
    end
  end

  defp divisible_by_4?(year), do: rem(year, 4) === 0
  defp divisible_by_100?(year), do: rem(year, 100) === 0
  defp divisible_by_400?(year), do: rem(year, 400) === 0
end


defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    elem(volume_pair, 1)
  end

  def to_milliliter({:cup, n}), do: {:milliliter, n * 240}
  def to_milliliter({:fluid_ounce, n}), do: {:milliliter, n * 30}
  def to_milliliter({:teaspoon, n}), do: {:milliliter, n * 5}
  def to_milliliter({:tablespoon, n}), do: {:milliliter, n * 15}
  def to_milliliter({:milliliter, n}), do: {:milliliter, n}

  def from_milliliter({:milliliter, n}, :cup), do: {:cup, n / 240}
  def from_milliliter({:milliliter, n}, :fluid_ounce), do: {:fluid_ounce, n / 30}
  def from_milliliter({:milliliter, n}, :teaspoon), do: {:teaspoon, n / 5}
  def from_milliliter({:milliliter, n}, :tablespoon), do: {:tablespoon, n / 15}
  def from_milliliter({:milliliter, n}, :milliliter), do: {:milliliter, n}

  def convert(volume_pair, unit) do
    {unit, get_volume(from_milliliter(to_milliliter(volume_pair), unit))}
  end
end



defmodule HighSchoolSweetheart do
  def first_letter(name) do
    String.trim(name)
    |> String.first()
  end

  def initial(name) do
    first_letter(name)
    |> String.upcase()
    |> Kernel.<>(".")
  end

  def initials(full_name) do
    String.split(full_name)
    |> Enum.map(&(initial(&1)))
    |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    "     ******       ******\n   **      **   **      **\n **         ** **         **\n**            *            **\n**                         **\n**     #{initials(full_name1)}  +  #{initials(full_name2)}     **\n **                       **\n   **                   **\n     **               **\n       **           **\n         **       **\n           **   **\n             ***\n              *\n"
  end
end



defmodule HighScore do
  @default_score 0

  def new() do
    %{}
  end

  def add_player(scores, name, score \\ @default_score) do
    Map.put(scores, name, score)
  end

  def remove_player(scores, name) do
    Map.delete(scores, name)
  end

  def reset_score(scores, name) do
    Map.put(scores, name, @default_score)
  end

  def update_score(scores, name, score) do
    Map.update(scores, name, score, &(&1 + score))
  end

  def get_players(scores) do
    Map.keys(scores)
  end
end


defmodule BirdCount do
  def today([]), do: nil
  def today([head | _tail]), do: head

  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]), do: [head + 1 | tail]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0]), do: true
  def has_day_without_birds?([0 | _tail]), do: true
  def has_day_without_birds?([_head | tail]), do: has_day_without_birds?(tail)

  def total([]), do: 0
  def total([head | tail]), do: head + total(tail)

  def busy_days([]), do: 0
  def busy_days([head | tail]) when head >= 5 do
    1 + busy_days(tail)
  end
  def busy_days([head | tail]) when head < 5 do
    busy_days(tail)
  end
end


defmodule Form do
  @moduledoc """
  A collection of loosely related functions helpful for filling out various forms at the city office.
  """

  @type address_map :: %{:street => String.t(), :postal_code => String.t(), :city => String.t()}
  @type address_tuple :: {street :: String.t(), postal_code :: String.t(), city :: String.t()}
  @type address :: address_map | address_tuple

  @doc """
  Generates a string of a given length.

  This string can be used to fill out a form field that is supposed to have no value.
  Such fields cannot be left empty because a malicious third party could fill them out with false data.
  """
  @spec blanks(n :: non_neg_integer()) :: String.t()
  def blanks(n) do
    String.duplicate("X", n)
  end

  @doc """
  Splits the string into a list of uppercase letters.

This is needed for form fields that don't offer a single input for the whole string,
but instead require splitting the string into a predefined number of single-letter inputs.
  """
  @spec letters(word :: String.t()) :: list(String.t())
  def letters(word) do
    word
    |> String.upcase()
    |> String.split("", trim: true)
  end

  @doc """
  Checks if the value has no more than the maximum allowed number of letters.

  This is needed to check that the values of fields do not exceed the maximum allowed length.
  It also tells you by how much the value exceeds the maximum.
  """
  @spec check_length(word :: String.t(), length :: non_neg_integer()) :: :ok | {:error, pos_integer()}
  def check_length(word, length) do
    diff = String.length(word) - length

    if diff <= 0 do
      :ok
    else
      {:error, diff}
    end
  end

  @doc """
  Formats the address as an uppercase multiline string.
  """
  @spec format_address(address) :: String.t()
  def format_address(%{street: street, postal_code: postal_code, city: city}) do
    format_address({street, postal_code, city})
  end

  def format_address({street, postal_code, city}) do
    """
    #{String.upcase(street)}
    #{String.upcase(postal_code)} #{String.upcase(city)}
    """
  end
end


defmodule TwoFer do
  @doc """
  Two-fer or 2-fer is short for two for one. One for you and one for me.
  """
  @spec two_fer(String.t()) :: String.t()
  def two_fer(name \\ "name")
  def two_fer(name) when name === "name" do
    "One for you, one for me."
  end
  def two_fer(name) when is_bitstring(name) do
    "One for #{name}, one for me."
  end
end
