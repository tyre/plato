-module (redis_worker).
-export ([init/0]).

init() ->
  loop().

loop() ->
  receive
  {Client, CommandList, Callback} when is_list(CommandList) andalso is_function(Callback) ->
    {ok, Val} = eredis:q(Client, CommandList),
    Callback(Val);
  {Client, CommandList} when is_list(CommandList) ->
    {ok, _Response} = eredis:q(Client, CommandList)
  end.