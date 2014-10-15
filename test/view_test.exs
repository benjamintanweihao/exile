defmodule ViewTest do
  use ExUnit.Case
  alias Exile.View
  alias Timex.Date, as: D

  @date "2014-10-15"

  @calendar_no_links "<a href=\"/elixir-lang/2014-10-14\">&lt;</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Oct 2014&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"/elixir-lang/2014-10-16\">&gt;</a><br/>Su Mo Tu We Th Fr Sa\n          1  2  3  4\n 5  6  7  8  9 10 11\n12 13 14 15 16 17 18\n19 20 21 22 23 24 25\n26 27 28 29 30 31\n\n"

  @calendar_links "<a href=\"/elixir-lang/2014-10-14\">&lt;</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Oct 2014&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"/elixir-lang/2014-10-16\">&gt;</a><br/>Su Mo Tu We Th Fr Sa\n          <a class=\"\" href=\"/elixir-lang/2014-10-01\">1</a>  <a class=\"\" href=\"/elixir-lang/2014-10-02\">2</a>  <a class=\"\" href=\"/elixir-lang/2014-10-03\">3</a>  <a class=\"\" href=\"/elixir-lang/2014-10-04\">4</a>\n <a class=\"\" href=\"/elixir-lang/2014-10-05\">5</a>  <a class=\"\" href=\"/elixir-lang/2014-10-06\">6</a>  <a class=\"\" href=\"/elixir-lang/2014-10-07\">7</a>  <a class=\"\" href=\"/elixir-lang/2014-10-08\">8</a>  <a class=\"\" href=\"/elixir-lang/2014-10-09\">9</a> <a class=\"\" href=\"/elixir-lang/2014-10-10\">10</a> <a class=\"\" href=\"/elixir-lang/2014-10-11\">11</a>\n<a class=\"\" href=\"/elixir-lang/2014-10-12\">12</a> <a class=\"\" href=\"/elixir-lang/2014-10-13\">13</a> <a class=\"\" href=\"/elixir-lang/2014-10-14\">14</a> <a class=\"current\" href=\"/elixir-lang/2014-10-15\">15</a> <a class=\"\" href=\"/elixir-lang/2014-10-16\">16</a> <a class=\"\" href=\"/elixir-lang/2014-10-17\">17</a> <a class=\"\" href=\"/elixir-lang/2014-10-18\">18</a>\n<a class=\"\" href=\"/elixir-lang/2014-10-19\">19</a> <a class=\"\" href=\"/elixir-lang/2014-10-20\">20</a> <a class=\"\" href=\"/elixir-lang/2014-10-21\">21</a> <a class=\"\" href=\"/elixir-lang/2014-10-22\">22</a> <a class=\"\" href=\"/elixir-lang/2014-10-23\">23</a> <a class=\"\" href=\"/elixir-lang/2014-10-24\">24</a> <a class=\"\" href=\"/elixir-lang/2014-10-25\">25</a>\n<a class=\"\" href=\"/elixir-lang/2014-10-26\">26</a> <a class=\"\" href=\"/elixir-lang/2014-10-27\">27</a> <a class=\"\" href=\"/elixir-lang/2014-10-28\">28</a> <a class=\"\" href=\"/elixir-lang/2014-10-29\">29</a> <a class=\"\" href=\"/elixir-lang/2014-10-30\">30</a> <a class=\"\" href=\"/elixir-lang/2014-10-31\">31</a>\n\n"

  test "displays the calendar without links" do
    assert @calendar_no_links == View.calendar("elixir-lang", @date, false)
  end

  test "displays the calendar with links" do
    assert @calendar_links == View.calendar("elixir-lang", @date, true)
  end

  test "displays the channel list" do
    # displays a channel list pointing to the correct links"
  end
end

