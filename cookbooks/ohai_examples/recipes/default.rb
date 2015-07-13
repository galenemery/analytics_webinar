#
# Cookbook Name:: ohai_examples
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'ohai_examples::network_ports'
include_recipe 'ohai_examples::sysctl'

include_recipe 'ohai::default'
