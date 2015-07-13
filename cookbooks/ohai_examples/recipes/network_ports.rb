ohai 'reload_network_ports' do
  plugin 'network_ports'
  action :nothing
end

cookbook_file "#{node['ohai']['plugin_path']}/network_ports.rb" do
  source 'plugins/network_ports.rb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'ohai[reload_network_ports]', :immediately
end

include_recipe 'ohai::default'
