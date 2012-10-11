-module (transfer_worker).

-export ([to_proplist/1, redis_to_riak/2]).


redis_to_riak(RiakClient, TrackedData) ->
  {RiakBucket, RiakKey} = riak_bucket_and_key(TrackedData),
  JSON = jsx:encode(TrackedData),
  riakc_pb_socket:put(RiakClient,
                      riakc_obj:new(RiakBucket, RiakKey, JSON)).

riak_bucket_and_key(Data) ->
  ParamString = redis_worker:parameterize(Data),
  Body = redis_worker:response_body(string:concat("http://localhost:7737/generate/bucket-and-key?", ParamString)),
  ParsedJson = dict:from_list(jsx:decode(list_to_binary(Body))),
  {dict:fetch(<<"bucket">>, ParsedJson), dict:fetch(<<"key">>, ParsedJson)}.

to_proplist([K,V | T]) -> [{K,V} | to_proplist(T)];
to_proplist([]) -> [].

% riakc_pb_socket:put(Client, Obj, Options)