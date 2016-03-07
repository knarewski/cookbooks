user = node["user"]

config_dir = if ["development", "test"].include?(node["hg_rails"]["env"])
  File.join("/", "home", user, node["hg_rails"]["app_name"], "config")
else
  File.join("/", "home", user, node["hg_rails"]["app_name"], "shared", "config")
end

directory config_dir do
  recursive true
  mode '0700'
  owner user
  group user
  action :create
end

# TODO: fix this more proper way
execute "chown app directory" do
  command "chown -R #{user}:#{user} #{File.join("/home", user, node["hg_rails"]["app_name"])}"
end

template File.join(config_dir, "database.yml") do
  source 'database.yml.erb'
  owner user
  group user
  mode '0700'
  not_if { File.exist?(File.join(config_dir, "database.yml")) }
end