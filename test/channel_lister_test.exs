defmodule ChannelListerTest do
  use ExUnit.Case
  alias Exile.ChannelLister, as: CL

  @host "irc.freenode.net"
  @port 6667

  @tag timeout: 60_000
  test "connecting to an IRC server" do
    {:ok, _pid} = Exile.list_channels(@host, @port)

    # NOTE: Uncomment to see the Bot in action.
    :timer.sleep 100000
  end

  test "parsing LIST message with valid response" do
    msg_1    = ":cameron.freenode.net 322 exile-bot-0 #orderdeck 6 :\r\n"
    expected = "#orderdeck"
    assert expected == CL.parse_message(msg_1)

    msg_2     = ":cameron.freenode.net 322 exile-bot-0 ##python-friendly 27 :We're like #python, but friendlier. | Ask, don't ask to ask. | 2.x or 3.x? http://bit.ly/py2vs3k  | Tutorial: http://doc"
    expected  = "##python-friendly"
    assert expected == CL.parse_message(msg_2)
  end

end
