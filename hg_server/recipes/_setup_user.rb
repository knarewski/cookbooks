user = node[:user]

home_dir = File.join("/", "home", user)
ssh_dir = File.join(home_dir, ".ssh")

user user do
  home home_dir
  shell '/bin/bash'
end

[home_dir, ssh_dir].each do |dir|
  directory dir do
    mode "700"
    owner user
    group user
    recursive true
  end
end

file "/etc/sudoers.d/admin" do
  content "%ADMIN ALL=(ALL) NOPASSWD:ALL"
  user "root"
  group "root"
  mode "0440"
end

if node[:user_sudo]
  group "ADMIN" do
    action :create
    members user
    append true
  end
end

if node["ssh_keys"].any?
  node["ssh_keys"].each do |ssh_key|
    ssh_authorize_key ssh_key["identifier"] do
      key ssh_key["value"]
      user user
    end
  end
end