include_recipe "nginx"
include_recipe "nginx::passenger"

nginx_root = node["hg_server"]["nginx"]["dir"]

node["hg_server"]["nginx"]["sites_available"].each do |site, options|
  template "#{nginx_root}/sites-available/#{site}.conf" do
    source 'nginx_site.conf.erb'
    owner "root"
    group "root"
    mode '0700'
    variables({ name: site }.merge(options))
    # not_if { File.exist?(File.join(nginx_root, "sites-available", "site.conf")) }
  end

  link "#{nginx_root}/sites-enabled/#{site}.conf" do
    to "#{nginx_root}/sites-available/#{site}.conf"
    # not_if { File.exist?(File.join(nginx_root, "sites-enabled", "site.conf")) }
  end
end

service "nginx" do
  action :restart
end