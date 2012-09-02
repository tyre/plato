%% simple server. This is utterly useless as is.
%% BUT IT LIVES

-module(server).
-export([start/0]).

start() ->
  RedisWorker = spawn(redis_worker, init, []),
  Watcher = spawn(watcher, loop, []),
  [RedisWorker, Watcher].