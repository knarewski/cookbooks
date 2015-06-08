execute "install git aware prompt" do
  user node["hg_rails"]["user"]
  environment ({ 'HOME' => ::Dir.home(node["hg_rails"]["user"]), 'USER' => node["hg_rails"]["user"] })
  command %{
    mkdir #{::Dir.home(node["hg_rails"]["user"])}/.bash
    cd #{::Dir.home(node["hg_rails"]["user"])}/.bash
    git clone git://github.com/jimeh/git-aware-prompt.git
    echo 'export GITAWAREPROMPT=~/.bash/git-aware-prompt' >> ~/.profile
    echo 'source $GITAWAREPROMPT/main.sh' >> ~/.profile
    echo \'export PS1=#{node['hg_rails']['git_aware_prompt']['ps1']}\' >> ~/.profile
    git config --global color.ui auto
  }
end