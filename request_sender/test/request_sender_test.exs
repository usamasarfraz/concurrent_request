defmodule RequestSenderTest do
  use ExUnit.Case
  doctest RequestSender

  test "greets the world" do
    assert RequestSender.hello() == :world
  end
end
