#
# Cookbook Name:: .
# Recipe:: ubuntu_deploy
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
require 'chef/provisioning/aws_driver'

with_chef_server  Chef::Config[:chef_server_url],
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]

name = node["aws_deploy"]["key_name"]

machine_batch do
  4.upto(9) do |i|
    machine "#{name}-web#{i}" do
      driver 'aws'
      machine_options :region => node["aws_deploy"]["region"],
        :location => node["aws_deploy"]["location"],
        :ssh_username => node["aws_deploy"]["ubuntu"]["ssh_username"],
        :convergence_options => {:ssl_verify_mode => :verify_none},
        :bootstrap_options =>{
          #:ssl_verify_mode => :verify_none,
          :instance_type => node["aws_deploy"]["instance_type"],
          :security_group_ids => node["aws_deploy"]["sg_ids"],
          #:subnet_id => "subnet-8ad1a6ef",
          :image_id => node["aws_deploy"]["ubuntu"]["image_id"],
          :key_name => node["aws_deploy"]["key_name"]
        }
  		  role 'base_ubuntu'
	  end
  end
end

include_recipe "aws_deploy::ubuntu_elb"
