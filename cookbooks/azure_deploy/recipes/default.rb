#
# Cookbook Name:: azure_deploy
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'chef/provisioning/azure_driver'
with_driver 'azure'

with_chef_server Chef::Config[:chef_server_url],
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]

include_recipe 'azure_deploy::azure-deploy-ubuntu-web01'
include_recipe 'azure_deploy::azure-deploy-ubuntu-web02'

#include_recipe 'azure_deploy::azure-deploy-lb'
