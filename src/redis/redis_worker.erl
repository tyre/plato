-module (redis_worker).
-export ([get_set/3, watch_set/3, transfer/2, send/2, send/3, get_hash/3]).

watch_set(Master, Client, SetKey) ->
  {ok, SetSize} = eredis:q(Client, ["SMEMBERS", SetKey]),
  case SetSize of
    0 ->
      timer:sleep(250), % don't DOS yo own redis!
      watch_set(Master, Client, SetKey);
    _ ->
      get_set(Master, Client, SetKey)
  end.

get_set(Master, Client, SetKey) ->
  {ok, Set} = eredis:q(Client, ["SMEMBERS", SetKey]),
  transfer(Master, Set),
  eredis:q(Client, ["PEXPIRE", SetKey, 1000]).

get_hash(From, Client, Key) ->
  Data = to_proplist(eredis:q(Client, ["HGET", Key])),
  From ! {tracked, Data}.

send(Client, Command) ->
  eredis:q(Client, Command).

send(Client, Command, Callback) ->
  {ok, Val} = eredis:q(Client, Command),
  Callback(Val).

transfer(Master, [H|Tail]) ->
  Master ! {transfer, H},
  transfer(Master, Tail);

transfer(_Master, []) ->
  nil.

to_proplist([K,V | T]) -> [{K,V} | to_proplist(T)];
to_proplist([]) -> [].