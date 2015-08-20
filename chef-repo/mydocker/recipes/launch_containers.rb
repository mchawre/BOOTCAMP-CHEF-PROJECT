#
# Cookbook Name:: mydocker
# Recipe:: launch_containers
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'mydocker::pull_images'

include_recipe 'mydocker::run_containers'
