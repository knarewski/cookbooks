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

config_dir = config_dirs.last
template File.join(config_dir, "database.yml") do
  source 'database.yml.erb'
  owner user
  group user
  mode '0664'
  variables node["hg_rails"]
  not_if { File.exist?(File.join(config_dir, "database.yml")) }
end