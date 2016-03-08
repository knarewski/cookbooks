class Array
  def self.wrap(object)
    if object.nil?
      []
    elsif object.respond_to?(:to_ary)
      object.to_ary || [object]
    else
      [object]
    end
  end
end

default["hg_server"]["nginx"]["version"] = "1.8.0"
default["hg_server"]["nginx"]["dir"] = "/etc/nginx"
default["hg_server"]["nginx"]["passenger"]["version"] = "5.0.23"
default["hg_server"]["nginx"]['passenger']['root'] = "/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini"
default["hg_server"]["nginx"]["passenger"]["ruby"] = "/home/#{node["user"]}/.rvm/gems/ruby-2.2.2/wrappers/ruby"
default["hg_server"]["nginx"]['repo_source'] = 'passenger'
default["hg_server"]["nginx"]['package_name'] = 'nginx-extras'
default["hg_server"]["nginx"]['passenger']['install_method'] = 'package'

nginx = node["hg_server"]["nginx"]

set["nginx"] = {
  version: nginx["version"],
  dir: nginx["dir"],
  repo_source: nginx["repo_source"],
  package_name: nginx["package_name"],
  passenger: {
    install_method: nginx["passenger"]["install_method"],
    version: nginx["passenger"]["version"],
    root: nginx["passenger"]["root"],
    ruby: nginx["passenger"]["ruby"]
  }
}

default["hg_server"]["nginx"]["sites_available"] = {}

node["hg_server"]["nginx"]["sites_available"].each do |site, options|
  default["hg_server"]["nginx"]["sites_available"][site]["listen"] = [80, 443]
  default["hg_server"]["nginx"]["sites_available"][site]["env"] = "production"
  default["hg_server"]["nginx"]["sites_available"][site]["root"] = File.join("/home", node["user"], site, "current", "public")
  default["hg_server"]["nginx"]["sites_available"][site]["passenger_ruby"] = ">>>>>FILL_ME<<<<<<"
  set["hg_server"]["nginx"]["sites_available"][site]["listen"] = Array.wrap(node["hg_server"]["nginx"]["sites_available"][site]["listen"])
  default["hg_server"]["nginx"]["sites_available"][site]["server_name"] = site
  set["hg_server"]["nginx"]["sites_available"][site]["server_name"] = Array.wrap(node["hg_server"]["nginx"]["sites_available"][site]["server_name"])
  default["hg_server"]["nginx"]["sites_available"][site]["locations"] = []
end


