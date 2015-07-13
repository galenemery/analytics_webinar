ohai 'reload_sysctl' do
  plugin 'sysctl'
  action :nothing
end

cookbook_file "#{node['ohai']['plugin_path']}/sysctl.rb" do
  source 'plugins/sysctl.rb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'ohai[reload_sysctl]', :immediately
end

include_recipe 'ohai::default'
