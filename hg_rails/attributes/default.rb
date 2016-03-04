default["hg_rails"]["environment"] = "development"
default["hg_rails"]["user"] = "vagrant"
default["hg_rails"]["system_packages"] = []

default["hg_rails"]["rubies"] = ["2.2.1"]
default["hg_rails"]["gems"] = ["bundler"]
default["hg_rails"]["default_ruby"] = node["hg_rails"]["rubies"].first
default["hg_rails"]["vagrant"]["system_chef_solo"] = '/opt/vagrant_ruby/bin/chef-solo'
default["hg_rails"]["rvmrc_settings"] = { rvm_gemset_create_on_use_flag: 1 }

gems_to_install = node["hg_rails"]["gems"].map do |g|
  { name: g }
end

default["rvm"]["user_installs"] = [
  {
    "user" => node["hg_rails"]["user"],
    "rubies" => node["hg_rails"]["rubies"],
    "default_ruby" => node["hg_rails"]["default_ruby"],
    "vagrant" => { "system_chef_solo" => node["hg_rails"]["vagrant"]["system_chef_solo"] },
    "global_gems" => gems_to_install,
    "rvmrc" => node["hg_rails"]["rvmrc_settings"]
  }
]