-module(redis_master).
-export([loop/0]).

loop() ->
  receive
    {_, send, Msg} ->
      spawn(redis_worker, init, []) ! list_to_tuple([self() | Msg]),
      loop();
    {_, Msg} ->
      io:format("Your Message: ~w~n", [Msg]),
      loop();
    stop ->
      io:format("Into the abyss...~n"),
      true
  end.