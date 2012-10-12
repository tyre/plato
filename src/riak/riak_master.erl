-module(riak_master).
-export([start/0, riak_client/0]).

%%% EXAMPLE DATA
%
% TrackedData = dict:from_list([{<<"app_name">>,<<"MySpace">>},{<<"agent_id">>,<<"Harold">>},{<<"event_name">>,<<"vom">>},{<<"entity_id">>,<<"my-wall">>},{<<"variation_ids">>,[<<"bacon">>, <<"swiss">>]},{<<"server_url">>,<<"http://localhost:7738/t.gif">>}])


start() ->
  RiakC = riak_client(),
  loop(RiakC).

loop(RiakClient) ->
  receive
    {store, Data} ->
      io:format("Storing some data."),
      TW = spawn(riak_worker, get_bucket_and_key, [self(), Data]),
      monitor(process, TW);
      % loop(RiakClient);
    {store, Bucket, Key, Data} ->
      TW = spawn(riak_worker, store, [RiakClient, Bucket, Key, Data]),
      monitor(process, TW);
      % loop(RiakClient);
    ping ->
      io:format("pong"),
      loop(RiakClient);
    {'DOWN', Ref, process, Pid2, Reason} ->
      io:format("Process with ID ~s has failed. Reason:~n~n~s", [Pid2, Reason]),
      demonitor(Ref); %how should we handle this? Logging!
    stop ->
      io:format("Into the abyss...~n"),
      true
  end.

riak_client() ->
  {ok, RiakC} = riakc_pb_socket:start_link("127.0.0.1", 8087),
  RiakC.