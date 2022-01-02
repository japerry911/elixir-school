defmodule Secrets do
  def secret_add(secret), do: &(&1 + secret)

  def secret_subtract(secret), do: &(&1 - secret)

  def secret_multiply(secret), do: &(&1 * secret)

  def secret_divide(secret), do: &(Integer.floor_div(&1, secret))

  def secret_and(secret), do: &(Bitwise.&&&(secret, &1))

  def secret_xor(secret), do: &(Bitwise.^^^(secret, &1))

  def secret_combine(secret_function1, secret_function2), do: &(secret_function2.(secret_function1.(&1)))
end


defmodule Rules do
  def eat_ghost?(power_pellet_active, touching_ghost), do: power_pellet_active and touching_ghost
  def score?(touching_power_pellet, touching_dot), do: touching_power_pellet or touching_dot
  def lose?(power_pellet_active, touching_ghost), do: not power_pellet_active and touching_ghost
  def win?(has_eaten_all_dots, power_pellet_active, touching_ghost), do: has_eaten_all_dots and not lose?(power_pellet_active, touching_ghost)
end

defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level == 0 and not legacy? -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 and not legacy? -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    cond do
      to_label(level, legacy?) in [:error, :fatal] -> :ops
      to_label(level, legacy?) == :unknown and legacy? -> :dev1
      to_label(level, legacy?) == :unknown and not legacy? -> :dev2
      true -> false
    end
  end
end


defmodule FreelancerRates do
  def daily_rate(hourly_rate), do: hourly_rate * 8.0
  def apply_discount(before_discount, discount), do: before_discount - (before_discount * (discount / 100))
  def monthly_rate(hourly_rate, discount), do: trunc(Float.ceil(apply_discount(daily_rate(hourly_rate) * 22, discount)))
  def days_in_budget(budget, hourly_rate, discount), do: Float.floor(budget / apply_discount(daily_rate(hourly_rate), discount), 1)
end


defmodule LanguageList do
  def new(), do: []
  def add(list, language), do: [language | list]
  def remove(list), do: tl(list)
  def first(list), do: hd(list)
  def count(list), do: length(list)
  def exciting_list?(list), do: "Elixir" in list
end


defmodule GuessingGame do
  def compare(secret_number, guess) when is_integer(secret_number) and is_integer(guess) do
    cond do
      guess == secret_number -> "Correct"
      abs(secret_number - guess) <= 1 -> "So close"
      guess > secret_number -> "Too high"
      guess < secret_number -> "Too low"
    end
  end

  def compare(secret_number, guess \\ :no_guess) when is_integer(secret_number) and not is_integer(guess) do
    "Make a guess"
  end
end

defmodule GuessingGame do
  def compare(secret_number, guess \\ :no_guess)

  def compare(secret_number, guess) when secret_number == guess do
    "Correct"
  end

  def compare(secret_number, guess) when guess != :no_guess and abs(secret_number - guess) <= 1 do
    "So close"
  end

  def compare(secret_number, guess) when guess != :no_guess and guess > secret_number do
    "Too high"
  end

  def compare(secret_number, guess) when guess != :no_guess and guess < secret_number do
    "Too low"
  end

  def compare(_secret_number, guess) when guess == :no_guess do
    "Make a guess"
  end
end

defmodule KitchenCalculator do
  def get_volume(volume_pair), do: elem(volume_pair, 1)

  def to_milliliter({:cup, volume}), do: {:milliliter, volume * 240}
  def to_milliliter({:teaspoon, volume}), do: {:milliliter, volume * 5}
  def to_milliliter({:tablespoon, volume}), do: {:milliliter, volume * 15}
  def to_milliliter({:fluid_ounce, volume}), do: {:milliliter, volume * 30}
  def to_milliliter({:milliliter, volume}), do: {:milliliter, volume}

  def from_milliliter({:milliliter, volume}, :cup), do: {:cup, volume / 240}
  def from_milliliter({:milliliter, volume}, :teaspoon), do: {:teaspoon, volume / 5}
  def from_milliliter({:milliliter, volume}, :tablespoon), do: {:tablespoon, volume / 15}
  def from_milliliter({:milliliter, volume}, :fluid_ounce), do: {:fluid_ounce, volume / 30}
  def from_milliliter({:milliliter, volume}, :milliliter), do: {:milliliter, volume}

  def convert(volume_pair, unit) do
    to_milliliter(volume_pair)
    |> from_milliliter(unit)
  end
end


defmodule HighSchoolSweetheart do
  def first_letter(name) do
    String.trim(name)
    |> String.first
  end

  def initial(name) do
    first_letter(name)
    |> String.upcase
    |> Kernel.<> "."
  end

  def initials(full_name) do
    String.split(full_name)
    |> Enum.map(&(initial(&1)))
    |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    #      ******       ******
    #    **      **   **      **
    #  **         ** **         **
    # **            *            **
    # **                         **
    # **     J. P.  +  C. H.     **
    #  **                       **
    #    **                   **
    #      **               **
    #        **           **
    #          **       **
    #            **   **
    #              ***
    #               *

    ~s"     ******       ******\n   **      **   **      **\n **         ** **         **\n**            *            **\n**                         **\n**     #{initials(full_name1)}  +  #{initials(full_name2)}     **\n **                       **\n   **                   **\n     **               **\n       **           **\n         **       **\n           **   **\n             ***\n              *\n"
  end
end


defmodule BirdCount do
  def today([]), do: nil
  def today([head | _tail]), do: head

  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]), do: [head + 1 | tail]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _tail]), do: true
  def has_day_without_birds?([_head | tail]), do: false or has_day_without_birds?(tail)

  def total([]), do: 0
  def total([head | tail]), do: head + total(tail)

  def busy_days([]), do: 0
  def busy_days([head | tail]) when head >= 5, do: 1 + busy_days(tail)
  def busy_days([head | tail]) when head < 5, do: 0 + busy_days(tail)
end


defmodule HighScore do
  @base_score 0

  def new(), do: %{}

  def add_player(scores, name, score \\ @base_score), do: Map.put(scores, name, score)

  def remove_player(scores, name), do: Map.delete(scores, name)

  def reset_score(scores, name), do: Map.put(scores, name, @base_score)

  def update_score(scores, name, score), do: Map.update(scores, name, score, fn current -> current + score end)

  def get_players(scores), do: Map.keys(scores)
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
  @spec blanks(non_neg_integer()) :: String.t()
  def blanks(n) do
    String.duplicate("X", n)
  end

  @doc """
  Splits the string into a list of uppercase letters.

  This is needed for form fields that don't offer a single input for the whole string,
  but instead require splitting the string into a predefined number of single-letter inputs.
  """
  @spec letters(String.t()) :: list(String.t)
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
  @spec check_length(String.t(), non_neg_integer()) :: :ok | { :error, pos_integer()}
  def check_length(word, length) do
    diff = String.length(word) - length

    if diff <= 0 do
      :ok
    else
      {:error, diff}
    end
  end

  def format_address(%{street: street, postal_code: postal_code, city: city}) do
    format_address({street, postal_code, city})
  end

  @doc """
  Formats the address as an uppercase multiline string.
  """
  @spec format_address(address()) :: String.t()
  def format_address({street, postal_code, city}) do
    """
    #{String.upcase(street)}
    #{String.upcase(postal_code)} #{String.upcase(city)}
    """
  end
end
