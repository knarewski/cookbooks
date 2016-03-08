# Plugins needed:
# vagrant plugin install vagrant-vbguest
# vagrant plugin install vagrant-librarian-chef-nochef

# Enable forwarding agent on your host machine, edit/create ~/.ssh/config and paste in:
#   Host                    *
#     ForwardAgent          yes

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.ssh.forward_agent = true

  # Configurate the virtual machine to use 2GB of RAM
  config.vm.provider :virtualbox do |vb|
    host = RbConfig::CONFIG['host_os']

    if host =~ /darwin/ # MACOS
      cpus = `sysctl -n hw.ncpu`.to_i
      mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
    elsif host =~ /linux/
      cpus = `nproc`.to_i
      mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
    else # static values for Windows
      cpus = 2
      mem = 2048
    end

    vb.customize ["modifyvm", :id, "--memory", mem]
    vb.customize ["modifyvm", :id, "--cpus", cpus]
  end

  # NFS is reported to improve performance like 10 times
  # it may ask you to provide sudo password to edit /etc/exports
  config.vm.network :private_network, ip: "192.168.255.225" # need to enable NFS

  public_key = File.open("public_key.pub", "r").read if File.exists?("public_key.pub")

  setup_script = <<-SCRIPT
    ssh-keyscan localhost >> ~/.ssh/known_hosts
    ssh-keyscan 127.0.0.1 >> ~/.ssh/known_hosts
  SCRIPT

  setup_script << "echo '#{public_key}' > ~/.ssh/authorized_keys"

  config.vm.provision "shell", inline: setup_script, privileged: false
end