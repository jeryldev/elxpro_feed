defmodule ElxproFeedWeb.PageLive.SidebarTest do
  use ElxproFeedWeb.ConnCase
  import Phoenix.LiveViewTest

  test "load elements of a sidebar", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")
    assert has_element?(view, "aside")
    assert has_element?(view, "#sidebar")
    assert has_element?(view, "[data-role=profile-background]")
    assert has_element?(view, "[data-role=profile-photo]")
    assert has_element?(view, "[data-role=profile-user]", "Jeryl Estopace")
    assert has_element?(view, "[data-role=profile-role]", "Elixir Developer")
    assert has_element?(view, "footer")
    assert has_element?(view, "[data-role=edit-profile]", "Edit Profile")
  end
end
