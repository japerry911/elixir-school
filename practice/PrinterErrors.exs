defmodule PrinterErrors do
  @invalid_letters Enum.filter(String.split(List.to_string(Enum.to_list(?n..?z)), ""), &(&1 != ""))

  def printer_error(s) do
    total = length(Enum.filter(String.split(s, ""), &(&1 != "")))
    errors = length(Enum.filter(String.split(s, ""), &(Enum.member?(@invalid_letters, &1))))
    "#{errors}/#{total}"
  end
end

IO.inspect PrinterErrors.printer_error("aaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbmmmmmmmmmmmmmmmmmmmxyz")
# "3/56"
