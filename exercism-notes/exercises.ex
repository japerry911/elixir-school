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

defmodule Username do
  def sanitize(username) do
    case username do
      [] -> []
      [letter | tail_username] when (letter >= 97 and letter <= 122) or letter == 95 -> [letter] ++ sanitize(tail_username)
      [letter | tail_username] when letter == 228 -> [?a] ++ [?e] ++ sanitize(tail_username)
      [letter | tail_username] when letter == 246 -> [?o] ++ [?e] ++ sanitize(tail_username)
      [letter | tail_username] when letter == 252 -> [?u] ++ [?e] ++ sanitize(tail_username)
      [letter | tail_username] when letter == 223 -> [?s] ++ [?s] ++ sanitize(tail_username)
      [_ | tail_username] -> sanitize(tail_username)
    end
  end
end


defmodule NameBadge do
  def print(id, name, department) do
    if id != nil do
      if department == nil do
        "[#{id}] - #{name} - OWNER"
      else
        "[#{id}] - #{name} - #{String.upcase(department)}"
      end
    else
      if department == nil do
        "#{name} - OWNER"
      else
        "#{name} - #{String.upcase(department)}"
      end
    end
  end
end


defmodule RPG.CharacterSheet do
  def welcome() do
    IO.puts("Welcome! Let's fill out your character sheet together.")
  end

  def ask_name() do
    String.trim(IO.gets("What is your character's name?\n"))
  end

  def ask_class() do
    String.trim(IO.gets("What is your character's class?\n"))
  end

  def ask_level() do
    String.to_integer(String.trim(IO.gets("What is your character's level?\n")))
  end

  def run() do
    welcome()

    name = ask_name()
    class = ask_class()
    level = ask_level()

    character_map = %{class: class, level: level, name: name}

    IO.inspect(character_map, label: "Your character")
  end
end


defmodule DateParser do
  def day(), do: "(?<day>\\d{1,2})"

  def month(), do: "(?<month>\\d{1,2})"

  def year(), do: "(?<year>\\d{4,4})"

  def day_names(), do: "(?<day_name>Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday)"

  def month_names() do
    "(?<month_name>January|February|March|April|May|June|July|August|September|October|November|December)"
  end

  def capture_day(), do: day()

  def capture_month(), do: month()

  def capture_year(), do: year()

  def capture_day_name(), do: day_names()

  def capture_month_name(), do: month_names()

  def capture_numeric_date(), do: "#{capture_day()}/#{capture_month()}/#{capture_year()}"

  def capture_month_name_date(), do: "#{capture_month_name()} #{capture_day()}, #{capture_year()}"

  def capture_day_month_name_date() do
    "#{capture_day_name()}, #{capture_month_name()} #{capture_day()}, #{capture_year()}"
  end

  def match_numeric_date(), do: ~r/^#{capture_numeric_date()}$/

  def match_month_name_date(), do: ~r/^#{capture_month_name_date()}$/

  def match_day_month_name_date(), do: ~r/^#{capture_day_month_name_date()}$/
end


defmodule TakeANumber do
  @initial_state 0

  def start() do
    spawn(fn -> loop(@initial_state) end)
  end

  defp loop(state) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state)
        loop(state)
      {:take_a_number, sender_pid} ->
        send(sender_pid, state + 1)
        loop(state + 1)
      :stop -> nil
      _ -> loop(state)
    end
  end
end


defmodule WineCellar do
  def explain_colors do
    [white: "Fermented without skin contact.",
     red: "Fermented with skin contact using dark-colored grapes.",
     rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(cellar, color, opts \\ []) do
    Keyword.get_values(cellar, color)
    |> filter_by_year(opts[:year])
    |> filter_by_country(opts[:country])
  end

  defp filter_by_year(wines, nil = _year), do: wines
  defp filter_by_country(wines, nil = _country), do: wines

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end


defmodule LibraryFees do
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)
  def before_noon?(datetime), do: datetime.hour() <= 11
  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      NaiveDateTime.to_date(NaiveDateTime.add(checkout_datetime, 2419200, :second))
    else
      NaiveDateTime.to_date(NaiveDateTime.add(checkout_datetime, 2505600, :second))
    end
  end
  def days_late(planned_return_date, actual_return_datetime) do
    days_diff = Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date)
    if days_diff <= 0 do
      0
    else
      days_diff
    end
  end
  def monday?(datetime) do
    Date.day_of_week(NaiveDateTime.to_date(datetime)) == 1
  end
  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout)
    return_datetime = datetime_from_string(return)
    actual_return = return_date(checkout_datetime)
    days_diff = days_late(actual_return, return_datetime)
    late_fee = days_diff * rate
    if monday?(return_datetime) do
      trunc(late_fee - (late_fee * 0.5))
    else
      late_fee
    end
  end
end

defmodule BoutiqueInventory do
  def sort_by_price(inventory), do: Enum.sort_by(inventory, &(&1.price))

  def with_missing_price(inventory), do: Enum.filter(inventory, &(&1.price == nil))

  def increase_quantity(item, count) do
    adj = Enum.map(Map.get(item, :quantity_by_size), fn ({size, cur}) -> {size, cur + count} end)
    map_adj = Enum.into(adj, %{})
    {_, final_map} = Map.get_and_update(item, :quantity_by_size, fn cur_key -> {cur_key, map_adj} end)
    final_map
  end

  def total_quantity(item) do
    Enum.reduce(Map.get(item, :quantity_by_size), 0, fn ({_k, v}, acc) -> acc + v end)
  end
end


defmodule Newsletter do
  def read_emails(path) do
    File.read!(path)
    |> String.split("\n")
    |> Enum.filter(&(&1 !== ""))
  end

  def open_log(path), do: File.open!(path, [:write])

  def log_sent_email(pid, email), do: IO.puts(pid, email)

  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    open_pid = open_log(log_path)
    emails_list = read_emails(emails_path)

    send_and_log_emails(emails_list, send_fun, open_pid)

    close_log(open_pid)
  end

  defp send_and_log_emails([email | []], send_fun, open_pid) do
    case send_fun.(email) do
      :ok -> log_sent_email(open_pid, email)
      _ -> nil
    end
  end
  defp send_and_log_emails([email | emails], send_fun, open_pid) do
    case send_fun.(email) do
      :ok ->
        log_sent_email(open_pid, email)
        send_and_log_emails(emails, send_fun, open_pid)
      _ -> send_and_log_emails(emails, send_fun, open_pid)
    end
  end
end


defmodule Chessboard do
  def rank_range(), do: 1..8

  def file_range(), do: ?A..?H

  def ranks(), do: Enum.to_list(rank_range())

  def files(), do: Enum.map(file_range(), &(<<&1>>))
end

defmodule Chessboard do
  def rank_range(), do: 1..8

  def file_range(), do: ?A..?H

  def ranks() do
    rank_range()
    |> Enum.to_list()
  end

  def files() do
    file_range()
    |> Enum.map(&(<<&1>>))
  end
end


defmodule BoutiqueSuggestions do

  @doc """
  This function calculates the cartesian product of the tops and bottom lists
    and returns it

  ## Parameters
    - tops: List of Maps that represent top clothing
    - bottoms: List of Maps that represent bottom clothing
    - options: Keyword List of options

  ## Returns
    - List of Maps showing the Cartesian Product of the tops and bottoms lists
  """
  @spec get_combinations(list(map()), list(map()), keyword()) :: list(map())
  def get_combinations(tops, bottoms, options \\ []) do
    for top <- tops,
        bottom <- bottoms,
        top[:base_color] != bottom[:base_color] and
        top[:price] + bottom[:price] <= Keyword.get(options, :maximum_price, 100)
    do
      {top, bottom}
    end
  end
end


defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate(list, fun), do: accumulate_helper(list, fun)

  defp accumulate_helper([], _fun), do: []
  defp accumulate_helper([head | list], fun), do: [fun.(head) | accumulate_helper(list, fun)]
end


defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    trimmed_input = String.trim(input)
    upper_input = String.upcase(trimmed_input)
    last_char = String.slice(trimmed_input, -1..-1)
    cond do
      trimmed_input == upper_input
        and trimmed_input != "" and Regex.match?(~r/.*[a-zA-Z].*/, trimmed_input)
        or trimmed_input == "УХОДИ" ->
        if last_char == "?" do
          "Calm down, I know what I'm doing!"
        else
          "Whoa, chill out!"
        end
      trimmed_input == "" -> "Fine. Be that way!"
      last_char == "?" -> "Sure."
      true -> "Whatever."
    end
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
    if rem(year, 4) == 0 do
      if rem(year, 100) == 0 do
        if rem(year, 400) == 0 do
          true
        else
          false
        end
      else
        true
      end
    else
      false
    end
  end
end


defmodule TwoFer do
  @doc """
  Two-fer or 2-fer is short for two for one. One for you and one for me.
  """
  def two_fer(), do: "One for you, one for me."
  @spec two_fer(String.t()) :: String.t()
  def two_fer(name) when is_binary(name), do: "One for #{name}, one for me."
end
