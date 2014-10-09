EXILE – An EliXir Irc LoggEr
============================

I am writing this because I'm too damned lazy to log into IRC, have an open window, and check on conversations I have missed. And yes, I do not know about [irclogger.com](http://irclogger.com/).

## Running

Run this command:

```
% iex -S mix
iex> Exile.Bot.run("irc.freenode.net", 6667, "#elixir-lang", "exile-bot")
```

## TODO

- [X] Bot working with one server
- [ ] Supervised bot
- [ ] Multiple bots working
- [ ] Writing out to a file
- [ ] Listing all the bots
- [ ] Stopping bots
- [X] `start_link` takes in a map

