defmodule ExampleDocumentationTest do
  use ExUnit.Case
  doctest ExampleDocumentation

  test "greets the world" do
    assert ExampleDocumentation.hello() == :world
  end
end
