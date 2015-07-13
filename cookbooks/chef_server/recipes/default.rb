#
# Cookbook Name:: chef_server
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.


execute 'Setup Chef Server' do
	command 'sudo chef-server-ctl marketplace-setup'
	# Need uninstall file
end
	