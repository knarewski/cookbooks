config_dir = if ["development", "test"].include?(node["hg_rails"]["env"])
  File.join("/", "home", node["user"], node["hg_rails"]["app_name"], "config")
else
  File.join("/", "home", node["user"], node["hg_rails"]["app_name"], "shared", "config")
end

directory config_dir do
  action :create
  recursive true
  owner node["user"]
  group node["user"]
end

template File.join(config_dir, "database.yml") do
  source 'database.yml.erb'
  owner node[:user]
  group node[:user]
  mode '0755'
  not_if { File.exist?(File.join(config_dir, "database.yml")) }
end