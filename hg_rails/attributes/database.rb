default["hg_rails"]["env"] = "production"

default["hg_rails"]["database"]["port"] = 3306
default["hg_rails"]["database"]["pool"] = 50
default["hg_rails"]["database"]["adapter"] = "mysql2"

if ["development", "test"].include?(node["hg_rails"]["env"])
  default["hg_rails"]["database"]["name"] = "#{node["hg_rails"]["app_name"]}_#{node["hg_rails"]["env"]}"
  default["hg_rails"]["database"]["username"] = "ADJUST_ME"
  default["hg_rails"]["database"]["password"] = "ADJUST_ME"
else
  database_attrs = Chef::EncryptedDataBagItem.load(node["data_bag_name"], "secrets")["database"]

  default["hg_rails"]["database"]["username"] = database_attrs["username"]
  default["hg_rails"]["database"]["database"] = database_attrs["database"]
  default["hg_rails"]["database"]["password"] = database_attrs["password"]
  default["hg_rails"]["database"]["host"]     = database_attrs["host"]
end