{application,plato,
             [{description,"App for persisting data from Redis to Riak"},
              {vsn,"0.0.2"},
              {registered,[]},
              {applications,[kernel,stdlib]},
              {mod,{plato_app,[]}},
              {env,[]},
              {modules,[myapp_app,myapp_sup,plato_app,plato_sup,r,
                        redis_master,redis_worker,server,watcher]}]}.
