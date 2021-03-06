# Plato

App for persisting and analysing site traffic data. Designed as a persistant backend for a Redis-based application (that feeds the data). Riak objects are encoded and stored with a content-type of `<<"application/json">>` for indexing purposes; indexing is not yet built into the application initialization.

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
2. `1> [RiakMaster, RedisMaster] = server:start().`
3. `2> RedisMaster ! {send, [set, "walrus", "bubbles"]}.`
4. `3> RedisMaster ! {send, [get, "walrus"]}.`

Similarly, RiakMaster handles logic related to moving data into Riak. There is some overlap, in that RedisMaster needs to know what to do with data once it is done with it. Ideally, however, RiakMaster can take in data without knowing anything about Redis.

## Responsibilities

### Redis

Redis will be the default, primary source of information to be transferred.

#### RedisMaster

Upon initialization, loops continuously until `stop` is received

- Generates non-blocking connection to Redis with optional authentication
- Monitors RedisWorker processes and handles errors/restarts processes as necessary
- Handles external dependencies for Redis interop (key generation, transfer knowledge)
- Sends one-off commands to Redis via `send/2` and `send/3`

#### RedisWorker

A processed spawned from any one of the publicly-facing redis_worker functions should be monitored for failure to protect against data loss. An individual worker can take one of a number of Redis IO tasks:

- __Watcher__:
  + watches a given Redis key that points to a set via `watch_set/3`
  + when the set has members, sends each member to it's Master in the form `{get_hash, Member}` via a call to `get_set/3`

- __Get Set__:
  + takes in a set key and SPOPs until it's empty, sending each member to it's RM in the form `{get_hash, Member}`

- __Get Hash__:
  + get's a hash of tracking data, given a key
  + returns the hash to its Master in the form `{tracked, Data}`

- __Anything Else__:
  + Issue a call to `send/2` or `send/3` (with a callback) to trigger one-off commands

### Riak

#### Riak Master

Handles the creation and management of Riak connections, as well as spawning and monitoring of RiakWorker processes.

`{store, Data}`

`{store, Bucket, Key, Data}`

#### Riak Worker

- stores data into Riak
- fetches key and bucket values, given a hash of data

