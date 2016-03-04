execute "install git aware prompt" do
  user node["user"]
  environment ({ 'HOME' => ::Dir.home(node["user"]), 'USER' => node["user"] })
  command %{
    mkdir #{::Dir.home(node["user"])}/.bash
    cd #{::Dir.home(node["user"])}/.bash
    git clone git://github.com/jimeh/git-aware-prompt.git
    echo 'export GITAWAREPROMPT=~/.bash/git-aware-prompt' >> ~/.profile
    echo 'source $GITAWAREPROMPT/main.sh' >> ~/.profile
    echo \'export PS1=#{node['hg_rails']['git_aware_prompt']['ps1']}\' >> ~/.profile
    git config --global color.ui auto
  }
end