-module(server).
-export([start/0]).

start() ->
  inets:start(),
  RedisMaster = spawn(redis_master, start, []),
  [self(), RedisMaster].