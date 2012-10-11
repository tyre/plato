-module(transfer_master).
-export([start/0, parameterize/1, getkey/1, getkey/2]).


start() ->
  RiakC = riak_client(),
  loop(RiakC).

loop(RiakClient) ->
  receive
    {transfer, Data} ->
      spawn(transfer_worker, redis_to_riak, [RiakClient, Data]),
      loop(RiakClient);
    ping ->
      io:format("pong"),
      loop(RiakClient);
    stop ->
      io:format("Into the abyss...~n"),
      true
  end.

riak_client() ->
  {ok, RiakC} = riakc_pb_socket:start_link("127.0.0.1", 8087),
  RiakC.

getkey(Params, Callback) when is_function(Callback) ->
  ParamString = parameterize(Params),
  {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} = httpc:request(string:concat("http://localhost:7737/riak/generate/key-and-bucket?", ParamString)),
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
