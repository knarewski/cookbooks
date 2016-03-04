default["hg_rails"] = {}
default["hg_rails"]["user_installs"] = []
default["hg_rails"]["env"] = "production"
default["hg_rails"]["app_name"] = "rails_app"

default['rvm']['gpg']['keyserver'] = { "keyserver"=>"hkp://keys.gnupg.net" }
default["rvm"]["user_installs"] = node["hg_rails"]["user_installs"]