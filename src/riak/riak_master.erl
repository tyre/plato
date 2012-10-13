-module(riak_master).
-export([start/0, riak_client/0]).

%%% EXAMPLE DATA
%
% TrackedData = dict:from_list([{<<"app_name">>,<<"MySpace">>},{<<"agent_id">>,<<"Harold">>},{<<"event_name">>,<<"vom">>},{<<"entity_id">>,<<"my-wall">>},{<<"variation_ids">>,[<<"bacon">>, <<"swiss">>]},{<<"server_url">>,<<"http://localhost:7738/t.gif">>},{<<"session_id">>, <<"32pfn29dn3232fs22fw3p2">>}]).
% {RiakM, RedisM} = server:start().
% RiakM ! {store, TrackedData}.
% RiakClient = riak_master:riak_client().
% {ok, Obj} = riakc_pb_socket:get(RiakClient,<<"MySpace">>,<<"MySpace/Harold/32pfn29dn3232fs22fw3p2/my-wall/vom/">>).

start() ->
  RiakC = riak_client(),
  loop(RiakC).

loop(RiakClient) ->
  receive
    {store, Data} ->
      io:format("Storing some data.~n"),
      TW = spawn(riak_worker, get_bucket_and_key, [self(), Data]),
      monitor(process, TW),
      loop(RiakClient);
    {store, Bucket, Key, Data} ->
      io:format("Storing:~n  Bucket:~p~n  Key:~p~n  Data:~p~n", [Bucket, Key, Data]),
      TW = spawn(riak_worker, store, [RiakClient, Bucket, Key, dict:to_list(Data)]),
      monitor(process, TW),
      loop(RiakClient);
    ping ->
      io:format("pong"),
      loop(RiakClient);
    {'DOWN', Ref, process, Pid2, Reason} ->
      io:format("Process with ID ~p has died. Exit Status:~n~p", [Pid2, Reason]),
      demonitor(Ref); %how should we handle this? Logging!
    stop ->
      io:format("Into the abyss...~n"),
      true
  end.

riak_client() ->
  {ok, RiakC} = riakc_pb_socket:start_link("127.0.0.1", 8087),
  RiakC.