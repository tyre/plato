{application,myapp,
             [{description,"App for persisting and analysing site traffic data"},
              {vsn,"0.0.2"},
              {registered,[]},
              {applications,[kernel,stdlib]},
              {mod,{myapp_app,[]}},
              {env,[]},
              {modules,[myapp_app,myapp_sup,redis_worker,server,watcher]}]}.
