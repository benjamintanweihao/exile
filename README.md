EXILE – An EliXir Irc LoggEr
============================

I am writing this because I'm too damned lazy to log into IRC, have an open window, and check on conversations I have missed. And yes, I do not know about [irclogger.com](http://irclogger.com/).

## Running

Run this command:

```
% exile -h <host> -p <port> -c <chan> -n <nick>
```

### Example

```
./exile -h irc.freenode.net -p 6667 -c #elixir-lang -n exile-bot
```

## TODO

- [X] Bot working with one server
- [ ] Supervised bot
- [ ] Multiple bots working
- [X] Option parsing
- [ ] Writing out to a file
- [ ] Listing all the bots
- [ ] Stopping bots
- [X] `start_link` takes in a map

