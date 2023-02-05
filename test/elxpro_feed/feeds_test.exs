defmodule ElxproFeed.FeedsTest do
  use ElxproFeed.DataCase

  import ElxproFeed.FeedsFixtures

  alias ElxproFeed.Feeds

  test "list feeds" do
    assert Feeds.list() |> Enum.count() >= 0
  end

  test "get_feed!/1 returns the feed with given id" do
    feed = feed_fixture()
    assert Feeds.get_feed!(feed.id) == feed
  end
end
