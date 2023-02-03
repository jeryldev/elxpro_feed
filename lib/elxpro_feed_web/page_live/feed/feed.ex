defmodule ElxproFeedWeb.PageLive.Feed do
  use ElxproFeedWeb, :live_component

  import ElxproFeedWeb.PageLive.Shared.Components
  import Phoenix.HTML.Form

  alias __MODULE__.Comment
  alias ElxproFeed.Comments
  alias ElxproFeed.Comments.Comment, as: CommentSchema

  def update(%{delete_comment: comment}, socket) do
    feed = socket.assigns.feed
    comments = Enum.reject(feed.comments, &(&1.id == comment.id))
    feed = Map.put(feed, :comments, comments)
    {:ok, assign(socket, :feed, feed)}
  end

  def update(%{new_comment: new_comment}, socket) do
    feed = socket.assigns.feed
    comments = [new_comment | feed.comments]
    feed = Map.put(feed, :comments, comments)
    {:ok, assign(socket, :feed, feed)}
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign(comment_changeset: Comments.change_comment(%CommentSchema{}))

    {:ok, socket}
  end

  def handle_event("validate", %{"comment" => comment_params}, socket) do
    comment_changeset = Comments.change_comment(%CommentSchema{}, comment_params)
    {:noreply, assign(socket, comment_changeset: comment_changeset)}
  end

  def handle_event("add_comment", %{"comment" => comment_params}, %{assigns: assigns} = socket) do
    feed_id = Map.get(assigns, :id)
    comment_params = Map.put(comment_params, "feed_id", feed_id)

    case Comments.create_comment(comment_params) do
      {:ok, comment} ->
        comment_changeset = Comments.change_comment(%CommentSchema{})
        send_update(__MODULE__, id: feed_id, new_comment: comment)
        {:noreply, assign(socket, comment_changeset: comment_changeset)}

      {:error, _error} ->
        {:noreply, socket}
    end
  end

  def post_comment_form(assigns) do
    ~H"""
    <.form
      :let={f}
      for={@changeset}
      phx-change="validate"
      phx-submit="add_comment"
      phx-target={@target}
      id={"comment-form-" <> @id}
      action="#"
      class="w-full mt-6 pt-6 border-t border-gray-600 leading-relaxed flex flex-col group"
    >
      <%= label(f, :content, "Post your comment", class: "text-gray-100") %>
      <%= textarea(f, :content,
        placeholder: "Post your comment",
        class: "bg-gray-900 border-0 resize-none h-24 p-4 rounded-sm text-gray-100 mt-4"
      ) %>

      <footer class="max-h-0 invisible group-focus-within:visible group-focus-within:max-h-[none]">
        <%= submit("Make a Comment",
          data_role: "add-comment",
          data_id: @id,
          disabled: !@changeset.valid?,
          class:
            "px-4 py-6 mt-4 rounded-lg bg-blue-900 [&:not(:disabled)]:hover:bg-blue-700 text-white font-bold cursor-pointer transition disabled:opacity-70 disabled:cursor-not-allowed"
        ) %>
      </footer>
    </.form>
    """
  end
end
