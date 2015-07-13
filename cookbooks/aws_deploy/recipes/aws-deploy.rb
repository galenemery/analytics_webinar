#
# Cookbook Name:: .
# Recipe:: aws-deploy
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
require 'chef/provisioning/aws_driver'


with_chef_server  Chef::Config[:chef_server_url],
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]

name = node["aws_deploy"]["key_name"]

machine_batch do
  1.upto(3) do |i|
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
  		  recipe 'apache::default'
	  end
  end
end


load_balancer "webapp-elb" do
  driver 'aws'
  load_balancer_options :availability_zones => node["aws_deploy"]["availability_zones"],
	  :listeners => [{
		  :port => 80,
		  :protocol => :http,
		  :instance_port => 80,
		  :instance_protocol => :http
		}]
  machines ["#{name}-web1", "#{name}-web2", "#{name}-web3"]
end
