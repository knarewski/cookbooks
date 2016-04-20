require 'yaml'

user = node["user"]

config_dirs = if ["development", "test"].include?(node["hg_rails"]["env"])
  [
    File.join("/home", user, node["hg_rails"]["app_name"]),
    File.join("/home", user, node["hg_rails"]["app_name"], "config")
  ]
else
  [
    File.join("/home", user, node["hg_rails"]["app_name"]),
    File.join("/home", user, node["hg_rails"]["app_name"], "shared"),
    File.join("/home", user, node["hg_rails"]["app_name"], "shared", "config")
  ]
end

config_dirs.each do |config_dir|
  directory config_dir do
    recursive true
    mode '0775'
    owner user
    group user
    action :create
  end
end

database_config = {}
raw_db_config = node["hg_rails"]["database"]

main_db_config = {
  "adapter"    => raw_db_config["adapter"],
  "database"   => raw_db_config["database"],
  "username"   => raw_db_config["username"],
  "password"   => raw_db_config["password"],
  "port"       => raw_db_config["port"],
  "pool"       => raw_db_config["pool"],
  "reconnect"  => true
}
main_db_config["host"] = raw_db_config["host"]         if raw_db_config["host"]
main_db_config["encoding"] = raw_db_config["encoding"] if raw_db_config["encoding"]
database_config[node["hg_rails"]["env"]] = main_db_config

if raw_db_config["additional_databases"].any?
  raw_db_config["additional_databases"].each do |database_name, database_hash|
    details = database_hash.to_hash
    database_config[database_name] = { node["hg_rails"]["env"] => details }
  end
end

config_dir = config_dirs.last
file File.join(config_dir, "database.yml") do
  content database_config.to_yaml
  owner user
  group user
  mode "0664"
end
