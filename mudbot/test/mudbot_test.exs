defmodule MudbotTest do
  use ExUnit.Case
  doctest Mudbot

  test "greets the world" do
    assert Mudbot.hello() == :world
  end
end
