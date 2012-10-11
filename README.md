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

1. From shell: `erl -pa ebin -pa deps/*/ebin`
2. `1> [TransferMaster, RedisMaster] = server:start().`
3. `2> RedisMaster ! {self(), send, [set, "walrus", "bubbles"]}.`
4. `3> RedisMaster ! {self(), send, [get, "walrus"]}.`

RedisMaster (RM) contains all necessary Redis interop functionality. Similarly, TransferMaster (TM) handles logic related to moving data into Riak. There is some overlap, in that RM needs to know what to do with data once it is done with it. Ideally, however, TM can take in data without knowing anything about Redis.