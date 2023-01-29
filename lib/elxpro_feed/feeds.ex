defmodule ElxproFeed.Feeds do
  alias __MODULE__.Feed
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
end
