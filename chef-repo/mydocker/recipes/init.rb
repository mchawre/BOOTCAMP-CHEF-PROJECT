#
# Cookbook Name:: mydocker
# Recipe:: init
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Install and configures docker
include_recipe 'mydocker::install'

include_recipe 'mydocker::launch_containers'
