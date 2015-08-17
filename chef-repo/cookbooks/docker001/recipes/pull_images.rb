#
# Cookbook Name:: docker001
# Recipe:: pull_images
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# For centos
if node['centos']['yes_no'] == 'YES'
	node['centos']['version'].each do |version, count|
		docker_image "chef/centos-#{version}" do
			action :pull_if_missing
		end
	end
end

# For ubuntu
if node['ubuntu']['yes_no'] == 'YES'
	node['ubuntu']['version'].each do |version, count|
		docker_image "chef/ubuntu-#{version}" do
			action :pull_if_missing
		end
	end
end

# For debian
if node['debian']['yes_no'] == 'YES'
	node['debian']['version'].each do |version, count|
		docker_image "chef/debian-#{version}" do
			action :pull_if_missing
		end
	end
end
