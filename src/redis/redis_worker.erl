-module (redis_worker).
-export ([init/0]).

init() ->
  io:format("I'm ALIIIIIIVE~n"),
  loop().

loop() ->
  receive
  {_From, Client, CommandList, Callback} when is_list(CommandList) andalso is_function(Callback) ->
    {ok, Val} = eredis:q(Client, CommandList),
    io:format("derp: ~s", [Callback(Val)]);
  {_From, Client, CommandList} when is_list(CommandList) ->
    {ok, _Response} = eredis:q(Client, CommandList)
  end.