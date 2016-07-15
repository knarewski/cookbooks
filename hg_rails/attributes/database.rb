default["hg_rails"]["env"] = "production"
default["hg_rails"]["database"]["port"] = 3306
default["hg_rails"]["database"]["pool"] = 50
default["hg_rails"]["database"]["adapter"] = "mysql2"

database_secrets = Chef::EncryptedDataBagItem.load(node["data_bag_name"], "secrets")["database"]
environment_secrets = Chef::EncryptedDataBagItem.load(node["data_bag_name"], "secrets")[node.chef_environment] || {}
env_database_secrets = environment_secrets["database"] || {}
database_secrets = Chef::Mixin::DeepMerge.deep_merge(database_secrets, env_database_secrets)

if ["development", "test"].include?(node["hg_rails"]["env"])
  default["hg_rails"]["database"]["name"]     = "#{node["hg_rails"]["app_name"]}_#{node["hg_rails"]["env"]}"
  default["hg_rails"]["database"]["username"] = "ADJUST_ME"
  default["hg_rails"]["database"]["password"] = "ADJUST_ME"
else
  default["hg_rails"]["database"]["username"] = database_secrets["username"]
  default["hg_rails"]["database"]["database"] = database_secrets["database"]
  default["hg_rails"]["database"]["password"] = database_secrets["password"]
  default["hg_rails"]["database"]["host"]     = database_secrets["host"]
end

default["hg_rails"]["database"]["additional_databases_use_env_namespace"] = true
default["hg_rails"]["database"]["additional_databases"] = {}
additional_databases_secrets = database_secrets.fetch("additional_databases", {})

basic_config_databases = node["hg_rails"]["database"]["additional_databases"].keys
secret_config_databases = additional_databases_secrets.keys
additional_databases_names = (basic_config_databases + secret_config_databases).uniq

additional_databases_names.each do |database_name|
  default["hg_rails"]["database"]["additional_databases"][database_name] = {}

  case node["hg_rails"]["database"]["additional_databases"][database_name]["adapter"]
  when "mysql2"
    default["hg_rails"]["database"]["additional_databases"][database_name]["port"] = 3306
    default["hg_rails"]["database"]["additional_databases"][database_name]["pool"] = 50
  end

  additional_databases_secrets.fetch(database_name, {}).each do |param_name, param_value|
    default["hg_rails"]["database"]["additional_databases"][database_name][param_name] = param_value
  end
end
