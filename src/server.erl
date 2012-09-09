%% simple server. This is utterly useless as is.
%% BUT IT LIVES

-module(server).
-export([start/0]).

start() ->
  inets:start().
  RedisMaster = spawn(redis_master, loop, []),
  [self(), RedisMaster].