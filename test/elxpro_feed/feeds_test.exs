defmodule ElxproFeed.FeedsTest do
  use ElxproFeed.DataCase
  alias ElxproFeed.Feeds

  test "list feeds" do
    assert Feeds.list() |> Enum.count() > 0
  end
end
