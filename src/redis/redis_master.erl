-module(redis_master).
-export([start/0, parameterize/1, client/0, getkey/1, getkey/2]).


start() ->
  C = client(),
  put(watchers, []),
  loop(C).

loop(Client) ->
  receive
    {send, Command} ->
      RW = spawn(redis_worker, send, [Client, Command]),
      monitor(process, RW),
      loop(Client);
    {send, Command, Callback} ->
      RW = spawn(redis_worker, send, [Client, Command, Callback]),
      monitor(process, RW),
      loop(Client);
    {'DOWN', Ref, process, _Pid2, _Reason} ->
      demonitor(Ref); %how should we handle this? Logging!
    {watch_set, TransferMaster, Key} ->
      NewWatcher = spawn(redis_worker, watch_set, [TransferMaster, Client, Key]),
      put(watchers,[get(watchers), NewWatcher]),
      loop(Client);
    {clear_watchers} ->
      clear_watchers(get(watchers));
    stop ->
      io:format("Into the abyss...~n"),
      true
  end.

clear_watchers([H|T]) ->
  exit(H, "Master clearing watchers"),
  clear_watchers(T);
clear_watchers([]) ->
  put(watchers, []).

client() ->
  {ok, Client} = eredis:start_link(),
  Client.

getkey(Params, Callback) when is_function(Callback) ->
  ParamString = parameterize(Params),
  {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} = httpc:request(string:concat("http://localhost:7737/generate/event?", ParamString)),
  ParsedJson = dict:from_list(jsx:decode(list_to_binary(Body))),
  Key = dict:fetch(<<"key">>, ParsedJson),
  Callback(Key).

getkey(Params) ->
  ParamString = parameterize(Params),
  Body = response_body(string:concat("http://localhost:7737/generate/event?", ParamString)),
  ParsedJson = dict:from_list(jsx:decode(list_to_binary(Body))),
  Key = dict:fetch(<<"key">>, ParsedJson),
  Key.

parameterize(Keys) -> string:join(lists:map(fun ({Key, Val}) -> string:join([Key, Val], "=") end, dict:to_list(Keys)), "&").

response_body(Url) ->
  {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} = httpc:request(Url),
  Body.
