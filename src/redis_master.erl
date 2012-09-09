-module(redis_master).
-export([loop/0]).

loop() ->
  receive
    {_, send, Msg} ->
      spawn(redis_worker, init, []) ! list_to_tuple([self() | Msg]),
      loop();
    {_, getkey, Params} ->
      {ok, {{Version, 200, ReasonPhrase}, Headers, Body}} = httpc:request("http://localhost:7737/gen-key/event?app-name=Facebook&event-name=pageView&time=8764326"),
      io:format("Your body: ~n~n~s~n~n", [Body];
    {_, Msg} ->
      io:format("Your Message: ~w~n", [Msg]),
      loop();
    stop ->
      io:format("Into the abyss...~n"),
      true
  end.

parameterize(Dict, Keys, Acc) ->
  case Keys of
    [H|T] ->
      string:concat(Acc, parameterize(Dict, lists:delete(H, Dict), Acc);
    true ->
      Acc
  end.
