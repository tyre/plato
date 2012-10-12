-module(redis_master).
-export([start/1, client/0]).


start(From) ->
  C = client(),
  put(watchers, []),
  loop(From,C).

loop(From, Client) ->
  receive
    {send, Command} ->
      RW = spawn(redis_worker, send, [Client, Command]),
      monitor(process, RW),
      loop(From, Client);
    {send, Command, Callback} ->
      RW = spawn(redis_worker, send, [Client, Command, Callback]),
      monitor(process, RW),
      loop(From, Client);
    {get_data, Key} ->
      RW = spawn(redis_worker, get_hash, [From, Client, Key]),
      monitor(process, RW);
    {transfer, Data} ->
      From ! {riak_store, Data},
      loop(From, Client);
    {watch_set, Key} ->
      NewWatcher = spawn(redis_worker, watch_set, [self(), Client, Key]),
      put(watchers,[get(watchers), NewWatcher]),
      loop(From, Client);
    {clear_watchers} ->
      clear_watchers(get(watchers));
    {'DOWN', Ref, process, _Pid2, _Reason} ->
      demonitor(Ref); %how should we handle this? Logging!
    stop ->
      io:format("Into the abyss...~n"),
      true
  end.

clear_watchers([H|T]) ->
  exit(H, "Master clearing watchers"),
  clear_watchers(T);
clear_watchers([]) ->
  put(watchers, []).

client() ->
  {ok, Client} = eredis:start_link(),
  Client.
