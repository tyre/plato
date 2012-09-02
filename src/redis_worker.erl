-module (redis_worker).
-export ([getKey/1, set/2, client/0, init/0, party/0]).

init() ->
  io:format("I'm ALIIIIIIVE", []),
  party().

party() ->
  receive
  {From, get, Key} when is_list(Key) ->
    Val = binary_to_list(getKey(Key)),
    From ! {self(), Val},
    party();
  {From, set, Key, Value} when is_list(Key) andalso is_list(Value) ->
    From ! set(Key, Value),
    party();
  {stop} ->
    io:format("STOPPING"),
    true
  end.

client() ->
  {_, Client} = eredis:start_link(),
  Client.

getKey(Key)  ->
  {ok, Val} = eredis:q(client(),["GET", Key]),
  Val.

set(Key, Value) ->
{ok, <<"OK">>} = eredis:q(client(), ["SET", Key, Value]),
io:format("Set key: ~s to ~s~n",[Key, Value]).