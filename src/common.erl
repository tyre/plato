-module (common).
-export([parameterize/1, response_body/1, to_proplist/1, parse_json_hash/1]).

parameterize(Keys) -> string:join(lists:map(fun ({Key, Val}) -> string:join([to_list(Key), to_list(Val)], "=") end, dict:to_list(Keys)), "&").

response_body(Url) ->
  {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} = httpc:request(Url),
  io:format("Body received from request to ~p:~n~p~n", [Url, Body]),
  Body.

parse_json_hash(Json) ->
  dict:from_list(jsx:decode(list_to_binary(Json))).

to_proplist([K,V | T]) -> [{K,V} | to_proplist(T)];

to_proplist([]) -> [].

to_list(V) when is_list(V) ->
  V;

to_list(V) when is_binary(V) ->
  binary_to_list(V);

to_list(V) when is_integer(V) ->
  integer_to_list(V).
