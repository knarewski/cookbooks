default["hg_server"]["redis"]["pidfile"]                     = "/var/run/redis/redis-server.pid"
default["hg_server"]["redis"]["daemonize"]                   = "yes"
default["hg_server"]["redis"]["port"]                        = 6379
default["hg_server"]["redis"]["bind"]                        = "127.0.0.1"
default["hg_server"]["redis"]["unixsocket"]                  = "/var/run/redis/redis.sock"
default["hg_server"]["redis"]["unixsocketperm"]              = 755
default["hg_server"]["redis"]["timeout"]                     = 300
default["hg_server"]["redis"]["loglevel"]                    = "notice"
default["hg_server"]["redis"]["logfile"]                     = "/var/log/redis/redis-server.log"
default["hg_server"]["redis"]["syslog_enabled"]              = "no"
default["hg_server"]["redis"]["syslog_ident"]                = "redis"
default["hg_server"]["redis"]["syslog_facility"]             = "local0"
default["hg_server"]["redis"]["databases"]                   = 16
default["hg_server"]["redis"]["snapshots"]                   = {
  900 => 1,
  300 => 10,
  60  => 10_000
}
default["hg_server"]["redis"]["stop_writes_on_bgsave_error"] = "yes"
default["hg_server"]["redis"]["rdbcompression"]              = "yes"
default["hg_server"]["redis"]["rdbchecksum"]                 = "yes"
default["hg_server"]["redis"]["dbfilename"]                  = "dump.rdb"
default["hg_server"]["redis"]["dir"]                         = "/var/lib/redis"
default["hg_server"]["redis"]["slaveof"]                     = ""
default["hg_server"]["redis"]["masterauth"]                  = ""
default["hg_server"]["redis"]["slave_serve_stale_data"]      = "yes"
default["hg_server"]["redis"]["slave_read_only"]             = "yes"
default["hg_server"]["redis"]["repl_ping_slave_period"]      = 10
default["hg_server"]["redis"]["repl_timeout"]                = 60
default["hg_server"]["redis"]["slave_priority"]              = 100
default["hg_server"]["redis"]["requirepass"]                 = ""
default["hg_server"]["redis"]["rename_commands"]             = []
default["hg_server"]["redis"]["maxclients"]                  = 128
default["hg_server"]["redis"]["maxmemory"]                   = "64mb"
default["hg_server"]["redis"]["maxmemory_policy"]            = "volatile-lru"
default["hg_server"]["redis"]["maxmemory_samples"]           = 3
default["hg_server"]["redis"]["appendonly"]                  = "no"
default["hg_server"]["redis"]["appendfilename"]              = "appendonly.aof"
default["hg_server"]["redis"]["appendfsync"]                 = "everysec"
default["hg_server"]["redis"]["no_appendfsync_on_rewrite"]   = "no"
default["hg_server"]["redis"]["auto_aof_rewrite_percentage"] = 100
default["hg_server"]["redis"]["auto_aof_rewrite_min_size"]   = "64mb"
default["hg_server"]["redis"]["lua_time_limit"]              = 5000
default["hg_server"]["redis"]["slowlog_log_slower_than"]     = 10_000
default["hg_server"]["redis"]["slowlog_max_len"]             = 1024
default["hg_server"]["redis"]["hash_max_ziplist_entries"]    = 512
default["hg_server"]["redis"]["hash_max_ziplist_value"]      = 64
default["hg_server"]["redis"]["list_max_ziplist_entries"]    = 512
default["hg_server"]["redis"]["list_max_ziplist_value"]      = 64
default["hg_server"]["redis"]["set_max_intset_entries"]      = 512
default["hg_server"]["redis"]["zset_max_ziplist_entries"]    = 128
default["hg_server"]["redis"]["zset_max_ziplist_value"]      = 64
default["hg_server"]["redis"]["activerehashing"]             = "yes"
default["hg_server"]["redis"]["client_output_buffer_limit"]  = {
  "normal" => "0 0 0",
  "slave"  => "256mb 64mb 60",
  "pubsub" => "32mb 8mb 60"
}
default["hg_server"]["redis"]["include_config_files"]        = []
default["hg_server"]["redis"]["ulimit"]                      = ""
default["hg_server"]["redis"]["auto_upgrade"]                = false