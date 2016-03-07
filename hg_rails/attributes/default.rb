default["hg_rails"] = {}
default["hg_rails"]["rvm"]["user_installs"] = []
default["hg_rails"]["env"] = "production"
default["hg_rails"]["app_name"] = "rails_app"

set['rvm']['gpg']['keyserver'] = { "keyserver"=>"hkp://keys.gnupg.net" }
set["rvm"]["user_installs"] = node["hg_rails"]["rvm"]["user_installs"]