defmodule ElxproFeedWeb.PageLive.Index do
  use ElxproFeedWeb, :live_view

  alias ElxproFeedWeb.PageLive.Feed
  alias ElxproFeedWeb.PageLive.Sidebar

  def mount(_params, _session, socket) do
    feeds = [
      %{
        id: "123",
        avatar_url: "https://avatars.githubusercontent.com/u/26645913?v=4",
        author: "Jeryl Estopace",
        role: "Software Engineer"
      },
      %{
        id: "1234",
        avatar_url: "https://avatars.githubusercontent.com/u/26645913?v=4",
        author: "Gustavo Oliviera",
        role: "Elixir Developer"
      },
      %{
        id: "1235",
        avatar_url: "https://avatars.githubusercontent.com/u/26645913?v=4",
        author: "Joe Morris",
        role: "Principal Engineer"
      }
    ]

    {:ok, assign(socket, feeds: feeds)}
  end
end
