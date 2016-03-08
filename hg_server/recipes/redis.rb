package "installing redis-server" do
  package_name "redis-server"
end

template "/etc/redis/redis.conf" do
  source "redis.conf.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  action :create
end

service "redis-server" do
  action :restart
end