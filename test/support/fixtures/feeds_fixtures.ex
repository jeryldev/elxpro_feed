defmodule ElxproFeed.FeedsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElxproFeed.Feeds` context.
  """

  @doc """
  Generate a feed.
  """
  def feed_fixture(attrs \\ %{}) do
    {:ok, feed} =
      attrs
      |> Enum.into(%{
        content: "some content",
        author: "Jeryl Estopace",
        avatar_url: "https://avatars.githubusercontent.com/u/26645913?v=4",
        role: "Software Engineer"
      })
      |> ElxproFeed.Feeds.create_feed()

    feed
  end
end
