directory "/home/#{node["user"]}/.bash" do
  user node["user"]
  group node["user"]
  recursive true
  action :create
end

git "/home/#{node["user"]}/.bash/git-aware-prompt" do
   repository 'https://github.com/jimeh/git-aware-prompt.git'
   action :sync
   user node["user"]
   group node["user"]
end

file "/home/#{node["user"]}/.profile" do
  user node["user"]
  action :create_if_missing
end

ruby_block "insert lines to ~/.profile" do
  block do
    file = Chef::Util::FileEdit.new("/home/#{node["user"]}/.profile")
    file.insert_line_if_no_match(/GITAWAREPROMPT=~/, "export GITAWAREPROMPT=~/.bash/git-aware-prompt")
    file.insert_line_if_no_match(/\$GITAWAREPROMPT/, "source $GITAWAREPROMPT/main.sh")
    file.insert_line_if_no_match(/PS1=/, "export PS1=#{node['hg_development']['git_aware_prompt']['ps1']}")
    file.write_file
  end
end

execute "set git config" do
  only_if "getent passwd #{node["user"]}"
  command "git config --global color.ui auto"
  user node["user"]
  environment ({ 'HOME' => "/home/#{node["user"]}", 'USER' => node["user"] })
end