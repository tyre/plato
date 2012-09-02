{application,plato,
             [{description,"App for persisting and analysing site traffic data"},
              {vsn,"0.0.2"},
              {registered,[]},
              {applications,[kernel,stdlib]},
              {mod,{plato_app,[]}},
              {env,[]},
              {modules,[myapp_app,myapp_sup,plato_app,plato_sup,redis_master,
                        redis_worker,server,watcher]}]}.
