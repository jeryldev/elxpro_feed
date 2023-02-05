defmodule ElxproFeedWeb.PageLive.Feed.CommentTest do
  use ElxproFeedWeb.ConnCase
  import ElxproFeed.CommentsFixtures
  import Phoenix.LiveViewTest

  test "load main comment elements", %{conn: conn} do
    comment = comment_fixture()
    {:ok, view, _html} = live(conn, ~p"/")

    comment_id = comment.id

    assert has_element?(view, "#comment-#{comment_id}")
    assert has_element?(view, "[data-role=avatar][data-id=#{comment_id}]")
    assert has_element?(view, "[data-role=user-name][data-id=#{comment_id}]", "Jeryl Estopace")
    assert has_element?(view, "[data-role=date][data-id=#{comment_id}]")
    assert has_element?(view, "[data-role=delete][data-id=#{comment_id}]")
    assert has_element?(view, "[data-role=content][data-id=#{comment_id}]")
    assert has_element?(view, "[data-role=footer][data-id=#{comment_id}]")
    assert has_element?(view, "[data-role=like][data-id=#{comment_id}]", "Like")
  end

  test "like comment - success", %{conn: conn} do
    comment = comment_fixture()
    {:ok, view, _html} = live(conn, ~p"/")

    like_element = "[data-role=like][data-id=#{comment.id}]"
    like_count_element = "[data-role=like_count][data-id=#{comment.id}]"

    # initial like count
    assert has_element?(view, like_count_element, Integer.to_string(comment.likes))

    assert view
           |> element(like_count_element)
           |> render() =~ Integer.to_string(comment.likes)

    # like a comment
    view
    |> element(like_element)
    |> render_click()

    # like count should increase by 1
    assert has_element?(view, like_count_element, Integer.to_string(comment.likes + 1))

    assert view
           |> element(like_count_element)
           |> render() =~ Integer.to_string(comment.likes + 1)
  end

  test "delete comment - success", %{conn: conn} do
    comment = comment_fixture()
    {:ok, view, _html} = live(conn, ~p"/")

    comment_id = comment.id
    assert has_element?(view, "#comment-#{comment_id}")

    delete_element = "[data-role=delete][data-id=#{comment_id}]"
    assert has_element?(view, delete_element)

    # delete a comment
    view
    |> element(delete_element)
    |> render_click()

    refute has_element?(view, "#comment-#{comment_id}")
  end
end
