DEFAULT_PACKAGES = %w(build-essential git-core curl)

(DEFAULT_PACKAGES + node["hg_server"]["apt_packages"]).each do |pkg|
  package "Installing package #{pkg}" do
    package_name pkg
  end
end

group "ADMIN" do
  action :create
end

sudo "ADMIN" do
  group    "%ADMIN"
  nopasswd true
  # setenv   true
end

include_recipe "hg_server::_setup_user"

if node["hg_server"]["users"].any?
  include_recipe "hg_server::users"
end