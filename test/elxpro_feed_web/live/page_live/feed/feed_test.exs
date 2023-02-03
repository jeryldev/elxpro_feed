defmodule ElxproFeedWeb.PageLive.FeedTest do
  use ElxproFeedWeb.ConnCase

  import Phoenix.LiveViewTest
  import ElxproFeed.CommentsFixtures

  alias ElxproFeed.Feeds

  test "load main feed elements", %{conn: conn} do
    comment = comment_fixture()
    {:ok, view, _html} = live(conn, ~p"/")

    feed_id = comment.feed_id

    feed = ElxproFeed.Repo.preload(comment, :feed).feed

    assert has_element?(view, "#feed-#{feed_id}")
    assert has_element?(view, "[data-role=avatar-url][data-id=#{feed_id}]")

    assert view
           |> element("[data-role=avatar-url][data-id=#{feed_id}]")
           |> render() =~
             "https://avatars.githubusercontent.com/u/26645913?v=4"

    assert has_element?(view, "[data-role=feed-header][data-id=#{feed_id}]")
    assert has_element?(view, "[data-role=feed-author][data-id=#{feed_id}]", feed.author)
    assert has_element?(view, "[data-role=feed-role][data-id=#{feed_id}]", feed.role)
    assert has_element?(view, "[data-role=feed-date][data-id=#{feed_id}]", "published at January")
    assert has_element?(view, "[data-role=feed-text][data-id=#{feed_id}]")
  end

  test "validate comment", %{conn: conn} do
    comment = comment_fixture()
    {:ok, view, _html} = live(conn, ~p"/")

    feed_id = comment.feed_id

    # comment field is empty and has no value of "pumpkin"
    refute view
           |> element("#comment-form-#{feed_id}_content")
           |> render() =~ "pumpkin"

    # submit button is disabled
    assert view
           |> element("[data-role=add-comment][data-id=#{feed_id}]")
           |> render() =~
             "disabled=\"disabled\""

    # comment field is changed and a value of "pumpkin" has been added
    view
    |> form("#comment-form-#{feed_id}", %{comment: %{content: "pumpkin"}})
    |> render_change()

    # comment field has a value of "pumpkin"
    assert view
           |> element("#comment-form-#{feed_id}_content")
           |> render() =~ "pumpkin"

    # submit button is enabled
    refute view
           |> element("[data-role=add-comment][data-id=#{feed_id}]")
           |> render() =~
             "disabled=\"disabled\""
  end

  test "add comment", %{conn: conn} do
    comment = comment_fixture()
    {:ok, view, _html} = live(conn, ~p"/")

    feed_id = comment.feed_id

    # comment field is changed and a value of "pumpkin" has been added
    view
    |> form("#comment-form-#{feed_id}", %{comment: %{content: "pumpkin"}})
    |> render_submit()

    comments = Feeds.get_comments(feed_id)

    assert comments |> Enum.count() >= 2

    Enum.each(comments, fn comment ->
      assert has_element?(view, "#comment-#{comment.id}")
    end)
  end
end
