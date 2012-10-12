-module (common).
-export([parameterize/1, response_body/1, to_proplist/1, parse_json_hash/1]).

parameterize(Keys) -> string:join(lists:map(fun ({Key, Val}) -> string:join([Key, Val], "=") end, dict:to_list(Keys)), "&").

response_body(Url) ->
  {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} = httpc:request(Url),
  Body.

parse_json_hash(Json) ->
  dict:from_list(jsx:decode(list_to_binary(Json))).

to_proplist([K,V | T]) -> [{K,V} | to_proplist(T)];

to_proplist([]) -> [].