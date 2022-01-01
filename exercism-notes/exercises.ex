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
