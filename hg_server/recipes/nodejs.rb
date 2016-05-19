include_recipe "nodejs"

node["hg_server"]["nodejs"]["packages"].each do |package|
  nodejs_npm package
end