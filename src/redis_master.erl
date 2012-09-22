-module(redis_master).
-export([loop/0]).

loop() ->
  receive
    {_From, send, Msg} ->
      spawn(redis_worker, init, []) ! list_to_tuple([self() | Msg]),
      loop();
    {_From, getkey, Params, Callback} ->
      % ParamString = parameterize(dict:new(), Params, ""),
      % io:format(ParamString),
      {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} = httpc:request("http://localhost:7737/generate/event?app-name=Facebook&event-name=pageView&time=8764326"),
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

parameterize(Dict, Keys, Acc) ->
  case Keys of
    [H|_] ->
      string:concat(Acc, parameterize(Dict, lists:delete(H, Dict), Acc));
    true ->
      Acc
  end.
