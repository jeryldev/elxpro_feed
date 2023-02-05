defmodule ElxproFeed.Feeds do
  import Ecto.Query, warn: false

  alias __MODULE__.Feed
  alias ElxproFeed.Comments.Comment
  alias ElxproFeed.Repo

  def list do
    Feed
    |> Repo.all()
    |> Repo.preload(:comments)
  end

  def create_feed(attrs \\ %{}) do
    %Feed{}
    |> Feed.changeset(attrs)
    |> Repo.insert()
  end

  def get_feed!(feed_id), do: Repo.get!(Feed, feed_id)

  def get_comments(feed_id) do
    Comment
    |> where([c], c.feed_id == ^feed_id)
    |> Repo.all()
  end
end
