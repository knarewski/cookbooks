default["hg_rails"]["env"] = "production"
default["hg_rails"]["database"]["port"] = 3306
default["hg_rails"]["database"]["pool"] = 50
default["hg_rails"]["database"]["adapter"] = "mysql2"

database_attrs = {}

if ["development", "test"].include?(node["hg_rails"]["env"])
  default["hg_rails"]["database"]["name"]     = "#{node["hg_rails"]["app_name"]}_#{node["hg_rails"]["env"]}"
  default["hg_rails"]["database"]["username"] = "ADJUST_ME"
  default["hg_rails"]["database"]["password"] = "ADJUST_ME"
else
  database_attrs = Chef::EncryptedDataBagItem.load(node["data_bag_name"], "secrets")["database"]

  default["hg_rails"]["database"]["username"] = database_attrs["username"]
  default["hg_rails"]["database"]["database"] = database_attrs["database"]
  default["hg_rails"]["database"]["password"] = database_attrs["password"]
  default["hg_rails"]["database"]["host"]     = database_attrs["host"]
end

default["hg_rails"]["database"]["include_additional_databases"] = false

if node["hg_rails"]["database"]["include_additional_databases"]
  default["hg_rails"]["database"]["additional_databases"] = {}
  additional_databases = database_attrs["additional_databases"] || []

  additional_databases.each do |database_name, database_attributes|
    default["hg_rails"]["database"]["additional_databases"][database_name] = {}
    default["hg_rails"]["database"]["additional_databases"][database_name]["port"] = 3306
    default["hg_rails"]["database"]["additional_databases"][database_name]["pool"] = 50
    default["hg_rails"]["database"]["additional_databases"][database_name]["adapter"] = "mysql2"
    default["hg_rails"]["database"]["additional_databases"][database_name]["username"] = database_attributes["username"]
    default["hg_rails"]["database"]["additional_databases"][database_name]["password"] = database_attributes["password"]
    default["hg_rails"]["database"]["additional_databases"][database_name]["database"] = database_attributes["database"]
    default["hg_rails"]["database"]["additional_databases"][database_name]["host"]     = database_attributes["host"]
  end
end