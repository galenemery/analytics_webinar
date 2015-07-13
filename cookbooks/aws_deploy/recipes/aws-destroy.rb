#
# Cookbook Name:: .
# Recipe:: aws-destroy
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'chef/provisioning/aws_driver'

with_chef_server  Chef::Config[:chef_server_url],
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]

name = node["aws_deploy"]["key_name"]

machine_batch do
	1.upto(3) do |i|
		machine "#{name}-prodweb#{i}" do
			driver 'aws'
  			machine_options :region => node["aws_deploy"]["region"],
  			                :location => node["aws_deploy"]["availability_zone"],
  			                :instance_type => node["aws_deploy"]["instance_type"],
  			                :image_id => node["aws_deploy"]["ubuntu"]["image_id"],
  				            :key_name => node["aws_deploy"]["key_name"],
  				            :ssh_username => node["aws_deploy"]["ubuntu"]["ssh_username"],
                      :convergence_options => {:ssl_verify_mode => :verify_none}
	end
  action :destroy
  end
end


load_balancer "#{name}webapp-elb" do
  driver 'aws'
  load_balancer_options :availability_zones => node["aws_deploy"]["availability_zone"],
		                :listeners => [{
		                     :port => 80,
		                     :protocol => :http,
		                     :instance_port => 80,
		                     :instance_protocol => :http
		                 }]
  machines ["#{name}-prodweb1","#{name}-prodweb2","#{name}-prodweb3"]
  action :destroy
end
