template "/home/#{node[:user]}/.ssh/id_rsa" do
  source 'private_key.erb'
  owner node[:user]
  group node[:user]
  mode '0700'
end

template "/home/#{node[:user]}/.ssh/id_rsa.pub" do
  source 'public_key.pub.erb'
  owner node[:user]
  group node[:user]
  mode '0700'
end