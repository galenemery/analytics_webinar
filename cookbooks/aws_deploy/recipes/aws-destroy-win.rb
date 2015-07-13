#
# Cookbook Name:: aws_deploy
# Recipe:: aws-deploy-win
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
require 'chef/provisioning/aws_driver'

with_chef_server Chef::Config[:chef_server_url],
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]

name = node["aws_deploy"]["machine_options"]["key_name"]

machine_batch do
1.upto(2) do |i|
		machine "#{name}-nopcommerce#{i}" do
		#machine node["aws_deploy"]["machine_options"]["key_name"]"nopcommerce#{i}" do
			driver 'aws'
			machine_options bootstrap_options: {
          :instance_type => node["aws_deploy"]["machine_options"]["instance_type"],
          :image_id => node["aws_deploy"]["machine_options"]["windows"]["image_id"],
          :key_name => node["aws_deploy"]["machine_options"]["key_name"],
        },
      :is_windows => true,
      :convergence_options => {:ssl_verify_mode => :verify_none},
      :region => node["aws_deploy"]["machine_options"]["region"],
      :location => node["aws_deploy"]["machine_options"]["location"]
    end
    action :destroy
  end
end

load_balancer "nopcommerce-elb" do
  driver 'aws'
  load_balancer_options :availability_zones => node["aws_deploy"]["load_balancer_options"]["availability_zones"],
    :listeners => [{
		  :port => 80,
		  :protocol => :http,
		  :instance_port => 80,
		  :instance_protocol => :http
		}]
    machines ["#{name}-nopcommerce1","#{name}-nopcommerce2"]
  action :destroy
end
