# Fix for Rubies > 2.2.2
sudo "Add sudo for apt-get update on app user" do
  user node["user"]
  runas 'root'
  nopasswd true
  commands ['/usr/bin/apt-get']
end

include_recipe "rvm::user"