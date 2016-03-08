default["hg_server"] = {}
default["hg_server"]["mysql"] = {}

default["hg_server"]["mysql"]["version"] = "5.6"
default["hg_server"]["mysql"]["port"] = "3306"
default["hg_server"]["mysql"]["server_root_password"] = "change_me!"
default["hg_server"]["mysql"]["actions"] = [:create, :start]
default["hg_server"]["mysql"]["service_name"] = 'default'

set["mysql"] = node["hg_server"]["mysql"]