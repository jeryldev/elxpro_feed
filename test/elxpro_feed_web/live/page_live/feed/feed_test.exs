defmodule ElxproFeedWeb.PageLive.FeedTest do
  use ElxproFeedWeb.ConnCase
  import Phoenix.LiveViewTest
  import ElxproFeed.CommentsFixtures

  test "load main feed elements", %{conn: conn} do
    comment = comment_fixture()
    {:ok, view, _html} = live(conn, ~p"/")

    feed_id = comment.feed_id

    assert has_element?(view, "#feed-#{feed_id}")
    assert has_element?(view, "[data-role=avatar-url][data-id=#{feed_id}]")

    assert view
           |> element("[data-role=avatar-url][data-id=#{feed_id}]")
           |> render() =~
             "https://avatars.githubusercontent.com/u/26645913?v=4"

    assert has_element?(view, "[data-role=feed-header][data-id=#{feed_id}]")
    assert has_element?(view, "[data-role=feed-author][data-id=#{feed_id}]", "Jeryl Estopace")
    assert has_element?(view, "[data-role=feed-role][data-id=#{feed_id}]", "Software Engineer")
    assert has_element?(view, "[data-role=feed-date][data-id=#{feed_id}]", "published at January")
    assert has_element?(view, "[data-role=feed-text][data-id=#{feed_id}]")
  end
end
