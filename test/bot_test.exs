defmodule BotTest do
  use ExUnit.Case
  alias Exile.Bot

  @host "irc.freenode.net"
  @port 6667
  @nick "exile-bot"
  @chan "exile-bot"

  # NOTE: This is a minimal implementation, without any 3rd party libraries,
  #       to talk to a IRC server. 

  # def handle_recv(sock) do
  #   receive do
  #     {:tcp, ^sock, data} ->
  #       IO.puts data
  #       handle_recv(sock)
  #     _ ->
  #       :ok
  #   end
  # end

  # @tag timeout: 30_000
  # test "the minimum needed to connect to an IRC server" do
  #   host = String.to_char_list @host
  #   nick = String.to_char_list @nick
  #   chan = String.to_char_list @chan
  #   {:ok, sock} = :gen_tcp.connect(host, @port, [{:packet, :line}])
  #
  #   :gen_tcp.send(sock, "NICK #{nick}\r\n")
  #   :gen_tcp.send(sock, "USER #{nick} #{host} #{nick} #{nick}\r\n")
  #   :gen_tcp.send(sock, "JOIN #{chan}\r\n")
  #
  #   handle_recv(sock)
  # end

  @tag timeout: 60_000
  test "connecting to an IRC server" do
    {:ok, _pid} = Exile.log(@host, @port, @chan)

    # NOTE: Uncomment to see the Bot in action.
    :timer.sleep 100000
  end

  @msg  ":bentanweihao!~bentanwei@27.96.106.134 PRIVMSG #elixir-lang :makes writing look like a walk in the park"
  test "parsing of PRIVMSG" do
    expected = "bentanweihao: makes writing look like a walk in the park"
    assert expected == Bot.parse_message(@msg, nil)
  end

end
