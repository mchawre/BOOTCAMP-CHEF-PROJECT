#
# Cookbook Name:: docker001
# Recipe:: start_containers
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# For centos
if node.attribute?("centos")
	$c = node['centos']['count']
	for i in 1..$c
        	docker_container "chef/centos-#{node['centos']['version']}-#{i}" do
			tty true
			command "sleep 10"
                	action :start
        	end
	end
end

# For ubuntu
if node.attribute?("ubuntu")
	$u = node['ubuntu']['count']
	for i in 1..$u
		docker_container "chef/ubuntu-#{node['ubuntu']['version']}-#{i}" do
			tty true
			command "sleep 10"
			action :start
		end
	end
end

# For debian
if node.attribute?("debian")
	$d = node['debian']['count']
	for i in 1..$d
		docker_container "chef/debian-#{node['debian']['version']}-#{i}" do
			tty true
			command "sleep 10"
		        action :start
		end
	end
end
