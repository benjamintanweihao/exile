EXILE – An EliXir Irc LoggEr
============================

I am writing this because I'm too damned lazy to log into IRC, have an open window, and check on conversations I have missed. And yes, I do not know about [irclogger.com](http://irclogger.com/).

## Running the Bot

```elixir
{:ok, pid} = Exile.Bot.start_link("irc.freenode.net", 6667, "#elixir-lang")
Bot.join_channel(pid)
Bot.listen(pid)
```

## How I think it should work

Run this command:

```
% exile -s <server> -p <port> -c <channel> -n <nick>
```

## TODO

- [X] Bot working with one server
- [ ] Supervised bot
- [ ] Multiple bots working
- [ ] Option parsing
- [ ] Writing out to a file
- [ ] Listing all the bots
- [ ] Stopping bots

