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
