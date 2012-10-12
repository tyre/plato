-module(server).
-export([start/0]).

start() ->
  inets:start(),
  {spawn(riak_master, start, []), spawn(redis_master, start, [self()])}.