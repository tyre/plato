-module(redis_master).
-export([start/0, parameterize/1]).


start() ->
  C = client(),
  loop(C).

loop(Client) ->
  receive
    {send, Command} ->
      spawn(redis_worker, init, []) ! {Client, Command},
      loop(Client);
    {send, Command, Callback} ->
      spawn(redis_worker, init, []) ! {Client, Command, Callback},
      loop(Client);
    {getkey, Params, Callback} when is_function(Callback) ->
      ParamString = parameterize(Params),
      {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} = httpc:request(string:concat("http://localhost:7737/generate/event?", ParamString)),
      ParsedJson = dict:from_list(jsx:decode(list_to_binary(Body))),
      Key = dict:fetch(<<"key">>, ParsedJson),
      io:format("Your body: ~n~n~s~n~n", [Key]),
      Callback(Key);
    {Msg} ->
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
