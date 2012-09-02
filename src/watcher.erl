-module(watcher).
-export([loop/0]).

loop() ->
  io:format("ready to rumble~n", []),
  receive
    {_, send, To, Message} ->
      To ! Message,
      loop();
    {From, Message} ->
      From ! io:format("Your Message (from ~w): ~w~n", [From,Message]),
      loop();
    stop ->
      io:format("Into the abyss...~n"),
      true
  end.