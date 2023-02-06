defmodule ElxproFeedWeb.PageLive.Feed.Comment do
  use ElxproFeedWeb, :live_component

  import ElxproFeed.Shared.DateUtils
  import ElxproFeedWeb.PageLive.Shared.Components

  alias ElxproFeed.Comments
  alias ElxproFeedWeb.PageLive.Feed

  def handle_event("like_comment", _params, socket) do
    comment = socket.assigns.comment
    likes = comment.likes + 1
    comment_params = %{"likes" => likes}

    {:ok, comment} = Comments.update_comment(comment, comment_params)

    {:noreply, update(socket, :comment, &%{&1 | likes: comment.likes})}
  end

  def handle_event("delete_comment", _params, socket) do
    comment = socket.assigns.comment

    {:ok, comment} = Comments.delete_comment(comment)

    send_update(Feed, id: comment.feed_id, delete_comment: comment)

    {:noreply, socket}
  end
end
