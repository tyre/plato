-module (riak_worker).

-export ([store/4, get_bucket_and_key/2]).


store(RiakClient, Bucket, Key, TrackedData) ->
  JSON = jsx:encode(TrackedData),
  riakc_pb_socket:put(RiakClient,
                      riakc_obj:new(Bucket, Key, JSON, <<"application/json">>)).

get_bucket_and_key(Master, Data) ->
  ParamString = common:parameterize(Data),
  Body = common:response_body(string:concat("http://localhost:7737/riak/generate/bucket-and-key?", ParamString)),
  ParsedJson = common:parse_json_hash(Body),
  {Bucket, Key} = {dict:fetch(<<"bucket">>, ParsedJson), dict:fetch(<<"key">>, ParsedJson)},
  Master ! {store, Bucket, Key, Data}.