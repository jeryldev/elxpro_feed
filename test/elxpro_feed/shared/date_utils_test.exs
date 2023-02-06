defmodule ElxproFeed.Shared.DateUtilsTest do
  use ElxproFeed.DataCase

  import ElxproFeed.CommentsFixtures

  alias ElxproFeed.Shared.DateUtils

  test "test published_at/1" do
    comment = comment_fixture()
    date = comment.inserted_at

    published_at_date = DateUtils.published_at(date)

    assert published_at_date == "0 minutes ago"
  end

  test "test published_at/1 - :year" do
    date = ~N[2020-02-06 10:03:36]
    published_at_date = DateUtils.published_at(date)

    assert published_at_date == "#{convert_to_number(date, :years)} ago"
  end

  test "test format_date/1" do
    comment = comment_fixture()
    date = comment.inserted_at

    formatted_date = DateUtils.format_date(date)
    timex_formatted_date = Timex.format!(date, "%Y-%m-%d %H:%M:%S %p", :strftime)

    assert formatted_date == timex_formatted_date
  end

  defp convert_to_number(date, type) do
    DateTime.utc_now()
    |> Timex.diff(date, type)
    |> then(&(Integer.to_string(&1) <> " " <> Atom.to_string(type)))
  end
end
