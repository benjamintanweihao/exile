defmodule Exile.View do
  use Phoenix.View, root: "web/templates"

  # Everything in this block is available runs in this
  # module and in other views that use MyApp.View
  using do
    # Import common functionality
    import Exile.I18n
    import Exile.Router.Helpers

    # Use Phoenix.HTML to import all HTML functions (forms, tags, etc)
    use Phoenix.HTML

    # Common aliases
    alias Phoenix.Controller.Flash
  end

  # Functions defined here are available to all other views/templates
  alias Timex.Date,       as: D
  alias Timex.DateFormat, as: DF

  def calendar(channel, formatted_date,  links \\ true) do
    {:ok, date } = formatted_date |> DF.parse("%F", :strftime)
    { cal, 0 } = System.cmd("cal", ["#{date.month}", "#{date.year}"])

    if links == true do
      cal = Regex.replace(~r/\b(\d{1,2})\b/, cal, fn _, d ->
              {day, _} = Integer.parse(d)
              formatted_date = {date.year, date.month, day}
                                |> D.from
                                |> DF.format!("%F", :strftime)
              current = if date.day == day do
                          "current"
                        else
                          ""
                        end

              ~s(<a class="#{current}" href="/#{channel}/#{formatted_date}">#{d}</a>)
            end)
    end

    prev_date  = date |> D.shift(days: -1)|> DF.format!("%F", :strftime)
    next_date  = date |> D.shift(days:  1)|> DF.format!("%F", :strftime)

    formatted_cal = cal |> String.split("\n")
                        |> Enum.drop(1)
                        |> Enum.join("\n")

    ~s{<a href="/#{channel}/#{prev_date}">&lt;</a>} <>
    ~s{#{calendar_header(date)}<a href="/#{channel}/#{next_date}">&gt;</a>} <>
    ~s{<br/>#{formatted_cal}}
  end

  defp calendar_header(date) do
    padding = String.duplicate("&nbsp;", 5)
    padding <> DF.format!(date, "%b %Y", :strftime) <> padding
  end
end
