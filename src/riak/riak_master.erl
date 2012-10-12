-module(riak_master).
-export([start/0, riak_client/0]).


start() ->
  RiakC = riak_client(),
  loop(RiakC).

loop(RiakClient) ->
  receive
    {store, Data} ->
      TW = spawn(transfer_worker, get_bucket_and_key, [self(), Data]),
      monitor(process, TW),
      loop(RiakClient);
    {store, Bucket, Key, Data} ->
      TW = spawn(transfer_worker, store, [RiakClient, Bucket, Key, Data]),
      monitor(process, TW),
      loop(RiakClient);
    ping ->
      io:format("pong"),
      loop(RiakClient);
    {'DOWN', Ref, process, _Pid2, _Reason} ->
      demonitor(Ref); %how should we handle this? Logging!
    stop ->
      io:format("Into the abyss...~n"),
      true
  end.

riak_client() ->
  {ok, RiakC} = riakc_pb_socket:start_link("127.0.0.1", 8087),
  RiakC.