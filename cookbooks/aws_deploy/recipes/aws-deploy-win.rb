#
# Cookbook Name:: aws_deploy
# Recipe:: aws-deploy-win
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
require 'chef/provisioning/aws_driver'

with_chef_server Chef::Config[:chef_server_url],
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]

name = node["aws_deploy"]["key_name"]

machine_batch do
1.upto(2) do |i|
  machine "#{name}-nopcommerce#{i}" do
	  driver 'aws'
		machine_options bootstrap_options: {
      :instance_type => node["aws_deploy"]["instance_type"],
      :image_id => node["aws_deploy"]["windows"]["image_id"],
      :key_name => node["aws_deploy"]["key_name"],
      :security_group_ids => node["aws_deploy"]["sg_id"],
      },
    :is_windows => true,
    :convergence_options => {:ssl_verify_mode => :verify_none},
    :region => node["aws_deploy"]["region"],
    :location => node["aws_deploy"]["availability_zone"]
    recipe 'nopcommerce::demo'
    end
  end
end

load_balancer "#{name}-nop-elb" do
  driver 'aws'
  load_balancer_options :availability_zones => node["aws_deploy"]["availability_zone"],
	  :listeners => [{
	  :port => 80,
		:protocol => :http,
		:instance_port => 80,
		:instance_protocol => :http
		}]
  machines ["#{name}-nopcommerce1","#{name}-nopcommerce2"]
end
