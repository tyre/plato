-module(redis_master).
-export([loop/0]).

loop() ->
  receive
    {_From, send, Msg} ->
      spawn(redis_worker, init, []) ! list_to_tuple([self() | Msg]),
      loop();
    {_From, getkey, Params, Callback} ->
      ParamString = parameterize(Params),
      io:format(ParamString),
      {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} = httpc:request(string:concat("http://localhost:7737/generate/event?", ParamString)),
      ParsedJson = jsx:decode(list_to_binary(Body)),
      Key = dict:fetch("key", ParsedJson),
      io:format("Your body: ~n~n~s~n~n", [Key]),
      Callback(Key);
    {_From, Msg} ->
      io:format("Your Message: ~w~n", [Msg]),
      loop();
    stop ->
      io:format("Into the abyss...~n"),
      true
  end.

parameterize(Keys) -> string:join(lists:map(fun ({Key, Val}) -> string:join([Key, Val], "=") end, dict:to_list(Keys)), "&").
