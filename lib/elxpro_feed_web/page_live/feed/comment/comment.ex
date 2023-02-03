defmodule ElxproFeedWeb.PageLive.Feed.Comment do
  use ElxproFeedWeb, :live_component

  import ElxproFeedWeb.PageLive.Shared.Components

  alias ElxproFeed.Comments
  alias ElxproFeedWeb.PageLive.Feed

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

  def handle_event("delete_comment", _params, socket) do
    comment = socket.assigns.comment

    case Comments.delete_comment(comment) do
      {:ok, comment} ->
        send_update(Feed, id: comment.feed_id, delete_comment: comment)
        {:noreply, socket}

      {:error, _} ->
        {:noreply, socket}
    end
  end
end
