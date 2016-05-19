# Description

This cookbook configures server for you.

# Avialbale recipes

 * `recipe["hg_server::default"]` - installs RVM and rubies for given users
 * `recipe["hg_server::nodejs"]` - install Nodejs with NPM and given packages
 * `recipe["hg_server::mysql"]` - installs mysql
 * `recipe["hg_server::nginx_passenger"]` - installs nginx with passenger ruby, additionally it creates sites for nginx conf
 * `recipe["hg_server::redis"]` - install redis and configures it

# Common attributes
```ruby
node["user"] = nil # user for whom we configure everything
node["user_sudo"] = true # wether user should be a sudoer
node["data_bag_name"] = nil # name of data bag used to keep secrets
```

# Recipes description
### default

Configures server

Available attributes with defaults:

```ruby
node["hg_server"]["apt_packages"] = ["build-essential", "git-core"] # list of apt packages to install
node["hg_server"]["ssh_keys"] = [] # list of public ssh keys to be authorized. Sample format:

node["hg_server"]["ssh_keys"] = [
 { identifier: "user@example.com", value: "AAAA322...." }
]

node["hg_server"]["users"] = {} # hash of additional user account to be added, example:

node["hg_server"]["users"] = {
  someone: {
    ssh_keys: [{ identifier: "someone@example.com", value: "AAAA23232..." }]
  },
  sudo: true # if sudoer
}
```

### deployment_keys

Configures deployment keys for server

Attributes:

```ruby
# You should store deployment keys inside data bag under key `deployment_keys`, format:

{
  "deployment_keys": {
    "private": "MIIEowIBAAKCAQEA5r......",
    "public": "ssh-rsa AAAAB3NzaC1yc......"
  }
}

```

### mysql

Installs and enables mysql server

Attributes with defaults:

```ruby
node["hg_server"]["mysql"]["version"] = "5.6"
node["hg_server"]["mysql"]["port"] = "3306"
node["hg_server"]["mysql"]["server_root_password"] = "change_me!"
node["hg_server"]["mysql"]["actions"] = [:create, :start]
node["hg_server"]["mysql"]["service_name"] = 'default'
```

### mysql_client

Installs mysql-client libs

No attributes needed.

### nginx_passenger

Installs and configures nginx, passenger, also creates nginx-site-enable

Attributes with defaults:

```ruby
node["hg_server"]["nginx"]["version"] = "1.8.0"
node["hg_server"]["nginx"]["dir"] = "/etc/nginx"
node["hg_server"]["nginx"]["passenger"]["version"] = "5.0.23"
node["hg_server"]["nginx"]['passenger']['root'] = "/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini"
node["hg_server"]["nginx"]['repo_source'] = 'passenger'
node["hg_server"]["nginx"]['package_name'] = 'nginx-extras'
node["hg_server"]["nginx"]['passenger']['install_method'] = 'package'
node["hg_server"]["nginx"]["sites_available"] = {}

# example sites_available with defaults where available

node["hg_server"]["nginx"]["sites_available"] = {
  some_site: {
    listen: [80, 443].
    env: "production",
    root: "/home/:user/some_site/current/public",
    server_name: "some_site",
    locations: [] # array of hashes location attributes
  }
}

# example location hash:

{
  operator: "~ ^/(assets)/",
  break: true
  options: {
    gzip_static: "on",
    expires: "max",
    add_header: "Cache-Control public",
    add_header: "Last-Modified \"\"",
    add_header: "ETag \"\"",
    open_file_cache: "max=1000 inactive=500s",
    open_file_cache_valid: "600s",
    open_file_cache_errors: "on"
  }
}
```

### Redis

Installs and enables Redis

Attributes for redis.conf with defaults:

```ruby
node["hg_server"]["redis"]["pidfile"]                     = "/var/run/redis/redis-server.pid"
node["hg_server"]["redis"]["daemonize"]                   = "yes"
node["hg_server"]["redis"]["port"]                        = 6379
node["hg_server"]["redis"]["bind"]                        = "127.0.0.1"
node["hg_server"]["redis"]["unixsocket"]                  = "/var/run/redis/redis.sock"
node["hg_server"]["redis"]["unixsocketperm"]              = 755
node["hg_server"]["redis"]["timeout"]                     = 300
node["hg_server"]["redis"]["loglevel"]                    = "notice"
node["hg_server"]["redis"]["logfile"]                     = "/var/log/redis/redis-server.log"
node["hg_server"]["redis"]["syslog_enabled"]              = "no"
node["hg_server"]["redis"]["syslog_ident"]                = "redis"
node["hg_server"]["redis"]["syslog_facility"]             = "local0"
node["hg_server"]["redis"]["databases"]                   = 16
node["hg_server"]["redis"]["snapshots"]                   = {
  900 => 1,
  300 => 10,
  60  => 10_000
}
node["hg_server"]["redis"]["stop_writes_on_bgsave_error"] = "yes"
node["hg_server"]["redis"]["rdbcompression"]              = "yes"
node["hg_server"]["redis"]["rdbchecksum"]                 = "yes"
node["hg_server"]["redis"]["dbfilename"]                  = "dump.rdb"
node["hg_server"]["redis"]["dir"]                         = "/var/lib/redis"
node["hg_server"]["redis"]["slaveof"]                     = ""
node["hg_server"]["redis"]["masterauth"]                  = ""
node["hg_server"]["redis"]["slave_serve_stale_data"]      = "yes"
node["hg_server"]["redis"]["slave_read_only"]             = "yes"
node["hg_server"]["redis"]["repl_ping_slave_period"]      = 10
node["hg_server"]["redis"]["repl_timeout"]                = 60
node["hg_server"]["redis"]["slave_priority"]              = 100
node["hg_server"]["redis"]["requirepass"]                 = ""
node["hg_server"]["redis"]["rename_commands"]             = []
node["hg_server"]["redis"]["maxclients"]                  = 128
node["hg_server"]["redis"]["maxmemory"]                   = "64mb"
node["hg_server"]["redis"]["maxmemory_policy"]            = "volatile-lru"
node["hg_server"]["redis"]["maxmemory_samples"]           = 3
node["hg_server"]["redis"]["appendonly"]                  = "no"
node["hg_server"]["redis"]["appendfilename"]              = "appendonly.aof"
node["hg_server"]["redis"]["appendfsync"]                 = "everysec"
node["hg_server"]["redis"]["no_appendfsync_on_rewrite"]   = "no"
node["hg_server"]["redis"]["auto_aof_rewrite_percentage"] = 100
node["hg_server"]["redis"]["auto_aof_rewrite_min_size"]   = "64mb"
node["hg_server"]["redis"]["lua_time_limit"]              = 5000
node["hg_server"]["redis"]["slowlog_log_slower_than"]     = 10_000
node["hg_server"]["redis"]["slowlog_max_len"]             = 1024
node["hg_server"]["redis"]["hash_max_ziplist_entries"]    = 512
node["hg_server"]["redis"]["hash_max_ziplist_value"]      = 64
node["hg_server"]["redis"]["list_max_ziplist_entries"]    = 512
node["hg_server"]["redis"]["list_max_ziplist_value"]      = 64
node["hg_server"]["redis"]["set_max_intset_entries"]      = 512
node["hg_server"]["redis"]["zset_max_ziplist_entries"]    = 128
node["hg_server"]["redis"]["zset_max_ziplist_value"]      = 64
node["hg_server"]["redis"]["activerehashing"]             = "yes"
node["hg_server"]["redis"]["client_output_buffer_limit"]  = {
  "normal" => "0 0 0",
  "slave"  => "256mb 64mb 60",
  "pubsub" => "32mb 8mb 60"
}
node["hg_server"]["redis"]["include_config_files"]        = []
node["hg_server"]["redis"]["ulimit"]                      = ""
node["hg_server"]["redis"]["auto_upgrade"]                = false
```

### nodejs

Installs nodejs, npm and desired node packages

Attributes:

```ruby
node["hg_server"]["nodejs"]["packages"] = [ "bower" ]
```