#
# Cookbook Name:: aws_deploy
# Recipe:: chef_server
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
require 'chef/provisioning/aws_driver'


# with_chef_server  Chef::Config[:chef_server_url],
#   :client_name => Chef::Config[:node_name],
#   :signing_key_filename => Chef::Config[:client_key]

name = node["aws_deploy"]["key_name"]

machine "#{name}-chefserver" do
	driver 'aws'
	machine_options :region => node["aws_deploy"]["region"],
	:location => node["aws_deploy"]["location"],
	:ssh_username => node["aws_deploy"]["chef_server"]["ssh_username"],
	:convergence_options => {:ssl_verify_mode => :verify_none},
	:bootstrap_options =>{
	  #:ssl_verify_mode => :verify_none,
	  :instance_type => node["aws_deploy"]["chef_server"]["instance_type"],
	  :security_group_ids => node["aws_deploy"]["sg_ids"],
	  #:subnet_id => "subnet-8ad1a6ef",
	  :image_id => node["aws_deploy"]["chef_server"]["image_id"],
	  :key_name => node["aws_deploy"]["key_name"]
	}
end