user = node[:user]

home_dir = File.join("/", "home", user)
ssh_dir = File.join(home_dir, ".ssh")

user user do
  home home_dir
  shell '/bin/bash'
end

directory home_dir do
  owner user
  group user
  recursive true
  mode '755'
end

directory ssh_dir do
  mode "700"
  owner user
  group user
  recursive true
end

if node[:user_sudo]
  group "ADMIN" do
    action :modify
    members user
    append true
  end
end

breakpoint 'name' do
  action :break
end

if node["ssh_keys"].any?
  node["ssh_keys"].each do |ssh_key|
    ssh_authorize_key ssh_key["identifier"] do
      key ssh_key["value"]
      user user
    end
  end
end