-module(server).
-export([start/0]).

start() ->
  inets:start(),
  {spawn(transfer_master, start, []), spawn(redis_master, start, [])}.