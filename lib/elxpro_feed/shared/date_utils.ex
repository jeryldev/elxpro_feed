defmodule ElxproFeed.Shared.DateUtils do
  def published_at(date) do
    cond do
      Timex.diff(DateTime.utc_now(), date, :hour) <= 24 -> convert_to_number(date, :hours)
      Timex.diff(DateTime.utc_now(), date, :day) <= 30 -> convert_to_number(date, :days)
      Timex.diff(DateTime.utc_now(), date, :month) <= 12 -> convert_to_number(date, :months)
      true -> convert_to_number(date, :years)
    end
  end

  defp convert_to_number(date, type) do
    DateTime.utc_now()
    |> Timex.diff(date, type)
    |> then(&(Integer.to_string(&1) <> " " <> Atom.to_string(type)))
  end
end
