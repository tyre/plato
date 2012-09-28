-module(r).
-compile(export_all).
% APPEND key value
% Append a value to a key
append(Client, Key, Value) ->
  eredis:q(Client, ["APPEND", Key, Value]).
% AUTH password
% Authenticate to the server
auth(Client, Password) ->
  eredis:q(Client, ["AUTH", Password]).
% BGREWRITEAOF
% Asynchronously rewrite the append-only file
bgrewriteaof(Client) ->
  eredis:q(Client, ["BGREWRITEAOF"]).
% BGSAVE
% Asynchronously save the dataset to disk
bgsave(Client) ->
  eredis:q(Client, ["BGSAVE"]).
% BITCOUNT key [start] [end]
% Count set bits in a string
bitcount(Client, Key) ->
  eredis:q(Client, ["BITCOUNT", Key]).

bitcount(Client, Key, Start, End) ->
  eredis:q(Client, ["BITCOUNT", Key, Start, End]).
% BITOP operation destkey key [key ...]
% Perform bitwise operations between strings
bitop(Client, Operation, DestKey, Keys) ->
  eredis:q(Client, ["BITOP", Client, Operation, DestKey, Keys]).
% BLPOP key [key ...] timeout
% Remove and get the first element in a list, or block until one is available
blpop(Client, Keys, Timeout) ->
  eredis:q(Client, ["BLPOP", Keys, Timeout]).
% BRPOP key [key ...] timeout
% Remove and get the last element in a list, or block until one is available
brpop(Client, Keys, Timeout) ->
  eredis:q(Client, ["BRPOP", Keys, Timeout]).
% BRPOPLPUSH source destination timeout
% Pop a value from a list, push it to another list and return it; or block until one is available
brpoplpush(Client, Source, Destination, Timeout) ->
  eredis:q(Client, ["BRPOPLPUSH", Source, Destination, Timeout]).
% CLIENT KILL ip:port
% Kill the connection of a client
client_kill(Client, IP_Port) ->
  eredis:q(Client, ["CLIENT KILL", IP_Port]).
% CLIENT LIST
% Get the list of client connections
client_list(Client) ->
  eredis:q(Client, ["CLIENT LIST"]).
% CONFIG GET parameter
% Get the value of a configuration parameter
config_get(Client, Parameter) ->
  eredis:q(Client, ["CONFIG GET", Parameter]).
% CONFIG SET parameter value
% Set a configuration parameter to the given value
config_set(Client, Parameter, Value) ->
  eredis:q(Client, ["CONFIG SET", Parameter, Value]).
% CONFIG RESETSTAT
% Reset the stats returned by INFO
config_resetstat(Client) ->
  eredis:q(Client, ["CONFIG RESETSTAT"]).
% DBSIZE
% Return the number of keys in the selected database
dbsize(Client) ->
  eredis:q(Client, ["DBSIZE"]).
% DEBUG OBJECT key
% Get debugging information about a key
debug_object(Client, Key) ->
  eredis:q(Client, ["DEBUG OBJECT", Key]).
% DEBUG SEGFAULT
% Make the server crash
debug_segfault(Client) ->
  eredis:q(Client, ["DEBUG SEGFAULT"]).
% DECR key
% Decrement the integer value of a key by one
decr(Client, Key) ->
  eredis:q(Client, ["DECR", Key]).
% DECRBY key decrement
% Decrement the integer value of a key by the given number\
decrby(Client, Key, Decrement) ->
  eredis:q(Client, ["DECRBY", Key, Decrement]).
% DEL key [key ...]
% Delete a key
del(Client, Keys) ->
  eredis:q(Client, ["DEL", Keys]).
% DISCARD
% Discard all commands issued after MULTI
discard(Client) ->
  eredis:q(Client, ["DISCARD"]).
% DUMP key
% Return a serialized version of the value stored at the specified key.
dump(Client, Key) ->
  eredis:q(Client, ["DUMP", Key]).
% ECHO message
% Echo the given string
echo(Client, Message) ->
  eredis:q(Client, ["ECHO", Message]).
% EVAL script numkeys key [key ...] arg [arg ...]
% Execute a Lua script server side
eval(Client, Script, NumKeys, Keys, Args) ->
  eredis:q(Client, ["EVAL", Script, NumKeys, Keys, Args]).
% EVALSHA sha1 numkeys key [key ...] arg [arg ...]
% Execute a Lua script server side
evalsha(Client, SHA1, NumKeys, Keys, Args) ->
  eredis:q(Client, ["EVALSHA", SHA1, NumKeys, Keys, Args]).
% EXEC
% Execute all commands issued after MULTI
exec(Client) ->
  eredis:q(Client, "EXEC").
% EXISTS key
% Determine if a key exists
exists(Client, Key) ->
  eredis:q(Client, ["EXISTS", Key]).
% EXPIRE key seconds
% Set a key's time to live in seconds
expire(Client, Key, Seconds) ->
  eredis:q(Client, ["EXPIRE", Key, Seconds]).
% EXPIREAT key timestamp
% Set the expiration for a key as a UNIX timestamp
expireat(Client, Key, Timestamp) ->
  eredis:q(Client, ["EXPIREAT", Key, Timestamp]).
% FLUSHALL
% Remove all keys from all databases
flushall(Client) ->
  eredis:q(Client, ["FLUSHALL"]).
% FLUSHDB
% Remove all keys from the current database
flushdb(Client) ->
  eredis:q(Client, ["FLUSHDB"]).
% GET key
% Get the value of a key
get(Client, Key) ->
  eredis:q(Client, ["GET", Key]).
% GETBIT key offset
% Returns the bit value at offset in the string value stored at key
getbit(Client, Key, Offset) ->
  eredis:q(Client, ["GETBIT", Key, Offset]).
% GETRANGE key start end
% Get a substring of the string stored at a key
getrange(Client, Key, Start, End) ->
  eredis:q(Client, ["GETRANGE", Key, Start, End]).
% GETSET key value
% Set the string value of a key and return its old value
getset(Client, Key, Value) ->
  eredis:q(Client, ["GETSET", Key, Value]).
% HDEL key field [field ...]
% Delete one or more hash fields
hdel(Client, Key, Fields) ->
  eredis:q(Client, ["HDEL", Key, Fields]).
% HEXISTS key field
% Determine if a hash field exists
hexists(Client, Key, Field) ->
  eredis:q(Client, ["HEXISTS", Key, Field]).
% HGET key field
% Get the value of a hash field
hget(Client, Key, Field) ->
  eredis:q(Client, ["HGET", Key, Field]).
% HGETALL key
% Get all the fields and values in a hash
hgetall(Client, Key) ->
  eredis:q(Client, ["HGETALL", Key]).
% HINCRBY key field increment
% Increment the integer value of a hash field by the given number
hincrby(Client, Key, Field, Increment) ->
  eredis:q(Client, ["HINCRBY", Key, Field, Increment]).
% HINCRBYFLOAT key field increment
% Increment the float value of a hash field by the given amount
hincrbyfloat(Client, Key, Field, Increment) ->
  eredis:q(Client, ["HINCRBYFLOAT", Key, Field, Increment]).
% HKEYS key
% Get all the fields in a hash
hkeys(Client, Key) ->
  eredis:q(Client, ["HKEYS", Key]).
% HLEN key
% Get the number of fields in a hash
hlen(Client, Key) ->
  eredis:q(Client, ["HLEN", Key]).
% HMGET key field [field ...]
% Get the values of all the given hash fields
hmget(Client, Key, Fields) ->
  eredis:q(Client, ["HMGET", Key, Fields]).
% HMSET key field value [field value ...]
% Set multiple hash fields to multiple values
hmset(Client, KeyValuePairs) ->
  eredis:q(Client, ["HMSET", KeyValuePairs]).
% HSET key field value
% Set the string value of a hash field
hset(Client, Key, Field, Value) ->
  eredis:q(Client, ["HSET", Key, Field, Value]).
% HSETNX key field value
% Set the value of a hash field, only if the field does not exist
hsetnx(Client, Key, Field, Value) ->
  eredis:q(Client, ["HSETNX", Key, Field, Value]).
% HVALS key
% Get all the values in a hash
hvals(Client, Key) ->
  eredis:q(Client, ["HVALS", Key]).
% INCR key
% Increment the integer value of a key by one
incr(Client, Key) ->
  eredis:q(Client, ["INCR", Key]).
% INCRBY key increment
% Increment the integer value of a key by the given amount
incrby(Client, Key, Increment) ->
  eredis:q(Client, ["INCRBY", Key, Increment]).
% INCRBYFLOAT key increment
% Increment the float value of a key by the given amount
incrbyfloat(Client, Key, Increment) ->
  eredis:q(Client, ["INCRBYFLOAT", Key, Increment]).
% INFO
% Get information and statistics about the server
info(Client) ->
  eredis:q(Client, ["INFO"]).
% KEYS pattern
% Find all keys matching the given pattern
keys(Client, Pattern) ->
  eredis:q(Client, ["KEYS", Pattern]).
% LASTSAVE
% Get the UNIX time stamp of the last successful save to disk
lastsave(Client) ->
  eredis:q(Client, ["LASTSAVE"]).
% LINDEX key index
% Get an element from a list by its index
lindex(Client, Key, Index) ->
  eredis:q(Client, ["LINDEX", Key, Index]).
% LINSERT key BEFORE|AFTER pivot value
% Insert an element before or after another element in a list
linsert(Client, Key, Where, Pivot, Value) ->
  eredis:q(Client, ["LINSERT", Key, Where, Pivot, Value]).
% LLEN key
% Get the length of a list
llen(Client, Key) ->
  eredis:q(Client, ["LLEN", Key]).
% LPOP key
% Remove and get the first element in a list
lpop(Client, Key) ->
  eredis:q(Client, ["LPOP", Key]).
% LPUSH key value [value ...]
% Prepend one or multiple values to a list
lpush(Client, Key, Values) ->
  eredis:q(Client, ["LPUSH", Key, Values]).
% LPUSHX key value
% Prepend a value to a list, only if the list exists
lpushx(Client, Key, Value) ->
  eredis:q(Client, ["LPUSHX", Key, Value]).
% LRANGE key start stop
% Get a range of elements from a list
lrange(Client, Key, Start, Stop) ->
  eredis:q(Client, ["LRANGE", Key, Start, Stop]).
% LREM key count value
% Remove elements from a list
lrem(Client, Key, Count, Value) ->
  eredis:q(Client, ["LREM", Key, Count, Value]).
% LSET key index value
% Set the value of an element in a list by its index
lset(Client, Key, Index, Value) ->
  eredis:q(Client, ["LSET", Key, Index, Value]).
% LTRIM key start stop
% Trim a list to the specified range
ltrim(Client, Key, Start, Stop) ->
  eredis:q(Client, ["LTRIM", Key, Start, Stop]).
% MGET key [key ...]
% Get the values of all the given keys
mget(Client, Keys) ->
  eredis:q(Client, ["MGET", Keys]).
% MIGRATE host port key destination-db timeout
% Atomically transfer a key from a Redis instance to another one.
migrate(Client, Host, Port, Key, Destination, Timeout) ->
  eredis:q(Client, ["MIGRATE", Host, Port, Key, Destination, Timeout]).
% MONITOR
% Listen for all requests received by the server in real time
monitor(Client) ->
  eredis:q(Client, ["MONITOR"]).
% MOVE key db
% Move a key to another database
move(Client, Key, Db) ->
  eredis:q(Client, ["MOVE", Key, Db]).
% MSET key value [key value ...]
% Set multiple keys to multiple values
mset(Client, KeyValuePairs) ->
  eredis:q(Client, ["MSET", KeyValuePairs]).
% MSETNX key value [key value ...]
% Set multiple keys to multiple values, only if none of the keys exist
msetnx(Client, KeyValuePairs) ->
  eredis:q(Client, ["MSETNX", KeyValuePairs]).
% MULTI
% Mark the start of a transaction block
multi(Client) ->
  eredis:q(Client, ["MULTI"]).
% OBJECT subcommand [arguments [arguments ...]]
% Inspect the internals of Redis objects
object(Client, SubCommand) ->
  eredis:q(Client, ["OBJECT", SubCommand]).

object(Client, SubCommand, Args) ->
  eredis:q(Client, ["OBJECT", SubCommand, Args]).
% PERSIST key
% Remove the expiration from a key
persist(Client, Key) ->
  eredis:q(Client, ["PERSIST", Key]).
% PEXPIRE key milliseconds
% Set a key's time to live in milliseconds
pexpire(Client, Key, Milliseconds) ->
  eredis:q(Client, ["PEXPIRE", Key, Milliseconds]).
% PEXPIREAT key milliseconds-timestamp
% Set the expiration for a key as a UNIX timestamp specified in milliseconds
pexpireat(Client, Key, Timestamp) ->
  eredis:q(Client, ["PEXPIREAT", Key, Timestamp]).
% PING
% Ping the server
ping(Client) ->
  eredis:q(Client, ["PING"]).
% PSETEX key milliseconds value
% Set the value and expiration in milliseconds of a key
psetex(Client, Key, Milliseconds, Value) ->
  eredis:q(Client, ["PSETEX", Key, Milliseconds, Value]).
% PSUBSCRIBE pattern [pattern ...]
% Listen for messages published to channels matching the given patterns
psubscribe(Client, Patterns) ->
  eredis:q(Client, ["PSUBSCRIBE", Patterns]).
% PTTL key
% Get the time to live for a key in milliseconds
pttl(Client, Key) ->
  eredis:q(Client, ["PTTL", Key]).
% PUBLISH channel message
% Post a message to a channel
publish(Client, Channel, Message) ->
  eredis:q(Client, ["PUBLISH", Channel, Message]).
% PUNSUBSCRIBE [pattern [pattern ...]]
% Stop listening for messages posted to channels matching the given patterns
punsubscribe(Client) ->
  eredis:q(Client, ["PUNSUBSCRIBE"]).

punsubscribe(Client, Patterns) ->
  eredis:q(Client, ["PUNSUBSCRIBE", Patterns]).
% QUIT
% Close the connection
quit(Client) ->
  eredis:q(Client, ["QUIT"]).
% RANDOMKEY
% Return a random key from the keyspace
randomkey(Client) ->
  eredis:q(Client, ["RANDOMKEY"]).
% RENAME key newkey
% Rename a key
rename(Client, Key, NewKey) ->
  eredis:q(Client, ["RENAME", Key, NewKey]).
% RENAMENX key newkey
% Rename a key, only if the new key does not exist
renamenx(Client, Key, NewKey) ->
  eredis:q(Client, ["RENAMENX", Key, NewKey]).
% RESTORE key ttl serialized-value
% Create a key using the provided serialized value, previously obtained using DUMP.
restore(Client, Key, TTL, SerializedValue) ->
  eredis:q(Client, ["RESTORE", Key, TTL, SerializedValue]).
% RPOP key
% Remove and get the last element in a list
rpop(Client, Key) ->
  eredis:q(Client, ["RPOP", Key]).
% RPOPLPUSH source destination
% Remove the last element in a list, append it to another list and return it
rpoplpush(Client, Source, Destination) ->
  eredis:q(Client, ["RPOPLPUSH", Source, Destination]).
% RPUSH key value [value ...]
% Append one or multiple values to a list
rpush(Client, Key, Values) ->
  eredis:q(Client, ["RPUSH", Key, Values]).
% RPUSHX key value
% Append a value to a list, only if the list exists
rpushx(Client, Key, Value) ->
  eredis:q(Client, ["RPUSHX", Key, Value]).
% SADD key member [member ...]
% Add one or more members to a set
sadd(Client, Key, Members) ->
  eredis:q(Client, ["SADD", Key, Members]).
% SAVE
% Synchronously save the dataset to disk
save(Client) ->
  eredis:q(Client, ["SAVE"]).
% SCARD key
% Get the number of members in a set
scard(Client, Key) ->
  eredis:q(Client, ["SCARD", Key]).
% SCRIPT EXISTS script [script ...]
% Check existence of scripts in the script cache.
script_exists(Client, Scripts) ->
  eredis:q(Client, ["SCRIPT EXISTS", Scripts]).
% SCRIPT FLUSH
% Remove all the scripts from the script cache.
script_flush(Client) ->
  eredis:q(Client, ["SCRIPT FLUSH"]).
% SCRIPT KILL
% Kill the script currently in execution.
script_kill(Client) ->
  eredis:q(Client, ["SCRIPT KILL"]).
% SCRIPT LOAD script
% Load the specified Lua script into the script cache.
script_load(Client, Script) ->
  eredis:q(Client, ["SCRIPT LOAD", Script]).
% SDIFF key [key ...]
% Subtract multiple sets
sdiff(Client, Keys) ->
  eredis:q(Client, ["SDIFF", Keys]).
% SDIFFSTORE destination key [key ...]
% Subtract multiple sets and store the resulting set in a key
sdiffstore(Client, Destination, Keys) ->
  eredis:q(Client, ["SDIFFSTORE", Destination, Keys]).
% SELECT index
% Change the selected database for the current connection
select(Client, Index) ->
  eredis:q(Client, ["SELECT", Index]).
% SET key value
% Set the string value of a key
set(Client, Key, Value) ->
  eredis:q(Client, ["SET", Key, Value]).
% SETBIT key offset value
% Sets or clears the bit at offset in the string value stored at key
setbit(Client, Key, Offset, Value) ->
  eredis:q(Client, ["SETBIT", Key, Offset, Value]).
% SETEX key seconds value
% Set the value and expiration of a key
setex(Client, Key, Seconds, Value) ->
  eredis:q(Client, ["SETEX", Key, Seconds, Value]).
% SETNX key value
% Set the value of a key, only if the key does not exist
setnx(Client, Key, Value) ->
  eredis:q(Client, ["SETNX", Key, Value]).
% SETRANGE key offset value
% Overwrite part of a string at key starting at the specified offset
setrange(Client, Key, Offset, Value) ->
  eredis:q(Client, ["SETRANGE", Key, Offset, Value]).
% SHUTDOWN [NOSAVE] [SAVE]
% Synchronously save the dataset to disk and then shut down the server
shutdown(Client) ->
  eredis:q(Client, ["SHUTDOWN"]).

shutdown(Client, Save) ->
  eredis:q(Client, ["SHUTDOWN", Save]).
% SINTER key [key ...]
% Intersect multiple sets
sinter(Client, Keys) ->
  eredis:q(Client, ["SINTER", Keys]).
% SINTERSTORE destination key [key ...]
% Intersect multiple sets and store the resulting set in a key
sinterstore(Client, Destination, Keys) ->
  eredis:q(Client, ["SINTERSTORE", Destination, Keys]).
% SISMEMBER key member
% Determine if a given value is a member of a set
sismember(Client, Key, Member) ->
  eredis:q(Client, ["SISMEMBER", Key, Member]).
% SLAVEOF host port
% Make the server a slave of another instance, or promote it as master
slaveof(Client, Host, Port) ->
  eredis:q(Client, ["SLAVEOF", Host, Port]).
% SLOWLOG subcommand [argument]
% Manages the Redis slow queries log
slowlog(Client, SubCommand) ->
  eredis:q(Client, ["SLOWLOG", SubCommand]).

slowlog(Client, SubCommand, Arg) ->
  eredis:q(Client, ["SLOWLOG", SubCommand, Arg]).
% SMEMBERS key
% Get all the members in a set
smembers(Client, Key) ->
  eredis:q(Client, ["SMEMBERS", Key]).
% SMOVE source destination member
% Move a member from one set to another
smove(Client, Source, Destination, Member) ->
  eredis:q(Client, ["SMOVE", Source, Destination, Member]).
% SORT key [BY pattern] [LIMIT offset count] [GET pattern [GET pattern ...]] [ASC|DESC] [ALPHA] [STORE destination]
% Sort the elements in a list, set or sorted set
sort(Client, Key) ->
  eredis:q(Client, ["SORT", Key]).

sort(Client, Key, Pattern) ->
  eredis:q(Client, ["SORT BY", Key, Pattern]).
%%%%% Figure this shit out %%%%%
% ["SORT BY", Key, Pattern]?
% ["SORT", "BY", Key, Pattern]?

% SPOP key
% Remove and return a random member from a set
spop(Client, Key) ->
  eredis:q(Client, ["SPOP", Key]).
% SRANDMEMBER key [count]
% Get one or multiple random members from a set
srandmember(Client, Key) ->
  eredis:q(Client, ["SRANDMEMBER", Key]).

srandmember(Client, Key, Count) ->
  eredis:q(Client, ["SRANDMEMBER", Key, Count]).
% SREM key member [member ...]
% Remove one or more members from a set
srem(Client, Key, Members) ->
  eredis:q(Client, ["SREM", Key, Members]).
% STRLEN key
% Get the length of the value stored in a key
strlen(Client, Key) ->
  eredis:q(Client, ["STRLEN", Key]).
% SUBSCRIBE channel [channel ...]
% Listen for messages published to the given channels
subscribe(Client, Channels) ->
  eredis:q(Client, ["SUBSCRIBE", Channels]).
% SUNION key [key ...]
% Add multiple sets
sunion(Client, Keys) ->
  eredis:q(Client, ["SUNION", Keys]).
% SUNIONSTORE destination key [key ...]
% Add multiple sets and store the resulting set in a key
sunionstore(Client, Destination, Keys) ->
  eredis:q(Client, ["SUNIONSTORE", Destination, Keys]).
% SYNC
% Internal command used for replication
sync(Client, Destination, Keys) ->
  eredis:q(Client, ["SYNC", Destination, Keys]).
% TIME
% Return the current server time
time(Client) ->
  eredis:q(Client, ["TIME"]).
% TTL key
% Get the time to live for a key
ttl(Client, Key) ->
  eredis:q(Client, ["TTL", Key]).
% TYPE key
% Determine the type stored at key
type(Client, Key) ->
  eredis:q(Client, ["TYPE", Key]).
% UNSUBSCRIBE [channel [channel ...]]
% Stop listening for messages posted to the given channels
unsubscribe(Client) ->
  eredis:q(Client, ["UNSUBSCRIBE"]).

unsubscribe(Client, Channels) ->
  eredis:q(Client, ["UNSUBSCRIBE", Channels]).
% UNWATCH
% Forget about all watched keys
unwatch(Client) ->
  eredis:q(Client, ["UNWATCH"]).
% WATCH key [key ...]
% Watch the given keys to determine execution of the MULTI/EXEC block
watch(Client, Keys) ->
  eredis:q(Client, ["WATCH", Keys]).
% ZADD key score member [score] [member]
% Add one or more members to a sorted set, or update its score if it already exists
zadd(Client, Key, ScoreMemberPairs) ->
  eredis:q(Client, ["ZADD", Key, ScoreMemberPairs]).
% ZCARD key
% Get the number of members in a sorted set
zcard(Client, Key) ->
  eredis:q(Client, ["ZCARD", Key]).
% ZCOUNT key min max
% Count the members in a sorted set with scores within the given values
zcount(Client, Key, Min, Max) ->
  eredis:q(Client, ["ZCOUNT", Key, Min, Max]).
% ZINCRBY key increment member
% Increment the score of a member in a sorted set
zincrby(Client, Key, Increment, Member) ->
  eredis:q(Client, ["ZINCRBY", Key, Increment, Member]).
% ZINTERSTORE destination numkeys key [key ...] [WEIGHTS weight [weight ...]] [AGGREGATE SUM|MIN|MAX]
% Intersect multiple sorted sets and store the resulting sorted set in a new key
zinterstore(Client, Destination, NumKeys, Keys) ->
  eredis:q(Client, ["ZINTERSTORE", Destination, NumKeys, Keys]).

%% ugh wtf y u no document examples like this?

% ZRANGE key start stop [WITHSCORES]
% Return a range of members in a sorted set, by index
zrange(Client, Key, Start, Stop) ->
  eredis:q(Client, ["ZRANGE", Key, Start, Stop]).

zrange(Client, Key, Start, Stop, withscores) ->
    eredis:q(Client, ["ZRANGE", Key, Start, Stop, "WITHSCORES"]).
% ZRANGEBYSCORE key min max [WITHSCORES] [LIMIT offset count]
% Return a range of members in a sorted set, by score
zrangebyscore(Client, Key, Min, Max) ->
  eredis:q(Client, ["ZRANGEBYSCORE", Key, Min, Max]).

zrangebyscore(Client, Key, Min, Max, withscores) ->
  eredis:q(Client, ["ZRANGEBYSCORE", Key, Min, Max, "WITHSCORES"]).

zrangebyscore(Client, Key, Min, Max, withscores, limit, Offset, Count) ->
  eredis:q(Client, ["ZRANGEBYSCORE", Key, Min, Max, "WITHSCORES", "LIMIT", Offset, Count]).

zrangebyscore(Client, Key, Min, Max, limit, Offset, Count) ->
  eredis:q(Client, ["ZRANGEBYSCORE", Key, Min, Max, "LIMIT", Offset, Count]).
% ZRANK key member
% Determine the index of a member in a sorted set
zrank(Client, Key, Member) ->
  eredis:q(Client, ["ZRANK", Key, Member]).
% ZREM key member [member ...]
% Remove one or more members from a sorted set
zrem(Client, Key, Members) ->
  eredis:q(Client, ["ZREM", Key, Members]).
% ZREMRANGEBYRANK key start stop
% Remove all members in a sorted set within the given indexes
zremrangebyrank(Client, Key, Start, Stop) ->
  eredis:q(Client, ["ZREMRANGEBYRANK", Key, Start, Stop]).
% ZREMRANGEBYSCORE key min max
% Remove all members in a sorted set within the given scores
zremrangebyscore(Client, Key, Start, Stop) ->
  eredis:q(Client, ["ZREMRANGEBYSCORE", Key, Start, Stop]).
% ZREVRANGE key start stop [WITHSCORES]
% Return a range of members in a sorted set, by index, with scores ordered from high to low
zrevrange(Client, Key, Start, Stop) ->
  eredis:q(Client, ["ZREVRANGE", Key, Start, Stop]).

zrevrange(Client, Key, Start, Stop, withscores) ->
  eredis:q(Client, ["ZREVRANGE", Key, Start, Stop, "WITHSCORES"]).
% ZREVRANGEBYSCORE key max min [WITHSCORES] [LIMIT offset count]
% Return a range of members in a sorted set, by score, with scores ordered from high to low
zrevrangebyscore(Client, Key, Max, Min) ->
  eredis:q(Client, ["ZREVRANGEBYSCORE", Key, Max, Min]).

zrevrangebyscore(Client, Key, Max, Min, withscores) ->
  eredis:q(Client, ["ZREVRANGEBYSCORE", Key, Max, Min, "WITHSCORES"]).

zrevrangebyscore(Client, Key, Max, Min, withscores, limit, Offset, Count) ->
  eredis:q(Client, ["ZREVRANGEBYSCORE", Key, Max, Min, "WITHSCORES", "LIMIT", Offset, Count]).

zrevrangebyscore(Client, Key, Max, Min, limit, Offset, Count) ->
  eredis:q(Client, ["ZREVRANGEBYSCORE", Key, Max, Min, "LIMIT", Offset, Count]).
% ZREVRANK key member
% Determine the index of a member in a sorted set, with scores ordered from high to low
zrevrank(Client, Key, Member) ->
  eredis:q(Client, ["ZREVRANK", Key, Member]).
% ZSCORE key member
% Get the score associated with the given member in a sorted set
zscore(Client, Key, Member) ->
  eredis:q(Client, ["ZSCORE", Key, Member]).
% ZUNIONSTORE destination numkeys key [key ...] [WEIGHTS weight [weight ...]] [AGGREGATE SUM|MIN|MAX]
% Add multiple sorted sets and store the resulting sorted set in a new key
zunionstore(Client, Destination, NumKeys, Keys, weights, Weights) ->
  eredis:q(Client, ["ZUNIONSTORE", Destination, NumKeys, Keys, "WEIGHTS", Weights]).

zunionstore(Client, Destination, NumKeys, Keys, weights, Weights, aggregate, SumMinMax) ->
  eredis:q(Client, ["ZUNIONSTORE", Destination, NumKeys, Keys, "WEIGHTS", Weights, "AGGREGATE", SumMinMax]).

% zunionstore(Client, Destination, NumKeys, Keys, aggregate, SumMinMax) ->
%   eredis:q(Client, ["ZUNIONSTORE", Destination, NumKeys, Keys, "AGGREGATE", SumMinMax]).
% This throws arity exception, not sure about a non-pain-in-the-ass way to do this