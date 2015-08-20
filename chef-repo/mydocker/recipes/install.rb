#
# Cookbook Name:: mydocker
# Recipe:: install
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Install and configures docker
docker_service 'default' do
  action [:create, :start]
end

