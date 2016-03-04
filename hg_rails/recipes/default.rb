DEFAULT_PACKAGES = %w(build-essential git-core curl)

execute "apt-get update"

(DEFAULT_PACKAGES + node["hg_rails"]["system_packages"]).each do |pkg|
  package pkg
end

include_recipe "rvm::user"

# This handles lack of .rvm function while ssh to user or while doing su - user
ruby_block "rvm: load rvm in .bashrc" do
  block do
    file = Chef::Util::FileEdit.new(::Dir.home(node["hg_rails"]["user"]) + "/.bashrc")
    file.insert_line_if_no_match(/scripts\/rvm/, "[[ -s \"$HOME/.rvm/scripts/rvm\" ]] && source \"$HOME/.rvm/scripts/rvm\"")
    file.write_file
  end
end