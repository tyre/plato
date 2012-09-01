%% simple server. This is utterly useless as is.
%% BUT IT LIVES

-module(server).
-export([start/0, loop/0]).

start() ->
  ServerPid = spawn(server, loop, []),
  io:format("Spawned the server! Returning ~w~n", [ServerPid]),
  ServerPid.

loop() ->
  receive
    {From, Message} ->
      From ! io:format("Your Message (from ~w): ~w~n", [From,Message]),
      loop();
    stop ->
      io:format("Into the abyss...~n"),
      true
  end.