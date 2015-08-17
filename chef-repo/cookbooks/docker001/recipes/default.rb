#
# Cookbook Name:: docker001
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Install and configures docker
docker_service 'default' do
  action [:create, :start]
end

include_recipe 'docker001::pull_images'

include_recipe 'docker001::run_containers'

#include_recipe 'docker001::start_containers'

#include_recipe 'docker001::stop_containers'

#include_recipe 'docker001::remove_containers'
