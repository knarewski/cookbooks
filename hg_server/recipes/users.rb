node["hg_server"]["users"].each do |user, data|
  home_dir = File.join("/", "home", user)

  user user do
    home home_dir
    shell '/bin/bash'
  end

  ssh_dir = File.join(home_dir, ".ssh")

  directory ssh_dir do
    mode "700"
    owner user
    group user
    recursive true
  end

  if data["sudo"]
    group "ADMIN" do
      action :modify
      members user
      append true
    end
  end

  if data["ssh_keys"].any?
    data["ssh_keys"].each do |ssh_key|
      ssh_authorize_key ssh_key["identifier"] do
        key ssh_key["value"]
        user user
      end
    end
  end
end