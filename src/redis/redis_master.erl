-module(redis_master).
-export([start/0]).


start() ->
  C = client(),
  loop(C).

loop(Client) ->
  receive
    {_From, send, Command} ->
      spawn(redis_worker, init, []) ! {self(), Client, Command},
      loop(Client);
    {_From, send, Command, Callback} ->
      spawn(redis_worker, init, []) ! {self(), Client, Command, Callback},
      loop(Client);
    {_From, getkey, Params, Callback} ->
      ParamString = parameterize(Params),
      {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} = httpc:request(string:concat("http://localhost:7737/generate/event?", ParamString)),
      ParsedJson = jsx:decode(list_to_binary(Body)),
      Key = dict:fetch("key", ParsedJson),
      io:format("Your body: ~n~n~s~n~n", [Key]),
      Callback(Key);
    {_From, Msg} ->
      io:format("Your Message: ~w~n", [Msg]),
      loop(Client);
    stop ->
      io:format("Into the abyss...~n"),
      true
  end.

client() ->
  {ok, Client} = eredis:start_link(),
  Client.

parameterize(Keys) -> string:join(lists:map(fun ({Key, Val}) -> string:join([Key, Val], "=") end, dict:to_list(Keys)), "&").
