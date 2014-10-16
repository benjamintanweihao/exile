defmodule Exile.View do
  use Phoenix.View, root: "web/templates"

  using do
    import Exile.I18n
    import Exile.Router.Helpers

    use Phoenix.HTML

    alias Phoenix.Controller.Flash
  end

  alias Timex.Date,       as: D
  alias Timex.DateFormat, as: DF

  def calendar(channel, formatted_date,  links \\ true) do
    {:ok, date } = formatted_date |> DF.parse("%F", :strftime)
    { cal, 0 }   = System.cmd("cal", ["#{date.month}", "#{date.year}"])

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

              channel_link(channel, formatted_date, d, current)
            end)
    end

    prev_date = date |> D.shift(days: -1)|> DF.format!("%F", :strftime)
    next_date = date |> D.shift(days:  1)|> DF.format!("%F", :strftime)

    formatted_cal = cal |> String.split("\n")
                        |> Enum.drop(1)
                        |> Enum.join("\n")

    channel_link(channel, prev_date, "&lt;") <>
    calendar_header(date) <>
    channel_link(channel, next_date, "&gt;") <>
    "<br/>#{formatted_cal}"
  end

  defp calendar_header(date) do
    padding = String.duplicate("&nbsp;", 5)
    padding <> DF.format!(date, "%b %Y", :strftime) <> padding
  end

  defp channel_link(channel, date, content, class \\ "") do
    channel = channel |> String.replace("#", ".")
    ~s{<a href="/#{channel}/#{date}" class="#{class}">#{content}</a>}
  end 

  def channels(nil, _), do: ""
  def channels([], _),  do: ""

  def channels(channels, date, current_channel \\ "") do
    Enum.map(channels, fn channel ->
      current = if current_channel == channel do
                  "current"
                else
                  ""
                end

      ~s(<li>
          #{channel_link(channel, date, channel, current)}
         </li>)
    end) |> Enum.join
  end

  def messages(nil) do
    "Welcome to EXILE – EXILE – An EliXir Irc LoggEr" <>
    " (Created by Benjamin Tan)"
  end

  def messages(messages) do
    messages 
    |> Enum.map(fn msg ->
         case String.split(msg, ":", parts: 2) do
           [user | line] -> 
             "#{format_nick(user)} #{format_line(line)}" 
           _ -> ""
         end
      end)
    |> Enum.join("<br/>")
  end

  defp format_nick(""), do: ""

  defp format_nick(nick) do
    ~s(<span class="nickname">&lt;#{nick}&gt;</span>)
  end

  defp format_line(line) do
    ~s(<span class="msg">#{line}</span>)
  end

end
