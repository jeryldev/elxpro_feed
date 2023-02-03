defmodule ElxproFeedWeb.PageLive.Feed.Comment do
  alias ElxproFeed.Comments
  use ElxproFeedWeb, :live_component

  import ElxproFeedWeb.PageLive.Shared.Components

  def handle_event("like_comment", _params, socket) do
    comment = socket.assigns.comment
    comment_params = %{"likes" => comment.likes + 1}

    case Comments.update_comment(comment, comment_params) do
      {:ok, comment} ->
        {:noreply, assign(socket, :comment, comment)}

      {:error, _} ->
        {:noreply, socket}
    end
  end
end
