Plato
=====

App for persisting and analysing site traffic data. Designed as a persistant backend for a Redis-based application (that feeds the data).

## Setup

#### Prereqs
  1. [rebar](https://github.com/basho/rebar)
  2. [redis](https://redis.io)

#### Install

1. `git clone git://github.com/tyre/plato.git` && `cd plato/`
2. run `rebar get-deps` to get the dependencies
3. run `rebar compile` inside the plato directory to compile

#### Try it out
(bash)    1.`$ erl -pa ebin -pa deps/*/ebin`
(Eshell)  2. `1> [_, Watcher] = server:start().`
          3. `Watcher ! {self(), send, [set, "walrus", "bubbles"]}.`
          4. `Watcher ! {self(), send, [get, "walrus"]}.`

There is currently a lot of noisy output. Sorry, I like to test with it and it will be gone when I'm more comfortable with Erlang. It's my party and I'll io:format if I want to.