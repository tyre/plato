-module (redis_worker).
-export ([get_set/3, watch_set/3, send/2, send/3, get_hash/3]).

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
  {ok, Mem} = eredis:q(Client, ["SPOP"]).
  case Mem of
    nil ->
      nil;
    _ ->
      Master ! {get_data, Mem},
      get_set(Master, Client, SetKey)
  end,
  eredis:q(Client, ["EXPIRE", SetKey, 1]).

get_hash(Master, Client, Key) ->
  Data = to_proplist(eredis:q(Client, ["HGET", Key])),
  Master ! {tracked, Data}.

send(Client, Command) ->
  eredis:q(Client, Command).

send(Client, Command, Callback) ->
  {ok, Val} = eredis:q(Client, Command),
  Callback(Val).

to_proplist([K,V | T]) -> [{K,V} | to_proplist(T)];
to_proplist([]) -> [].