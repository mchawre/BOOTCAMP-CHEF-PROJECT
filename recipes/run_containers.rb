#
# Cookbook Name:: docker001
# Recipe:: run_containers
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Script file is uploaded on node
cookbook_file '/mnt/docker/init_container.sh' do
  source 'init_container.sh'
  mode '0777'
  action :create
end

# For centos
if node['centos']['yes_no'] == 'YES'
	$name = node['centos']['name']
	node['centos']['version'].each do |version, count|
		$c = count
		for i in 1..$c
			docker_container "chef/centos-#{version}-#{i}" do
		        	detach true
		        	container_name "#{node['centos']['name']}_#{i}"
				image "chef/centos-#{version}"
				port "520#{i}:520#{i}"
				env 'SETTINGS_FLAVOR=local'
				volume "/mnt/docker:/docker-storage"
				command "/bin/sh /docker-storage/init_container.sh centos_container_#{i} gslab /docker-storage/centos_container_#{i}.json"
			end
		end
	end
end

# For ubuntu
if node['ubuntu']['yes_no'] == 'YES'
	$name = node['ubuntu']['name']
	node['ubuntu']['version'].each do |version, count|
		$c = count
		for i in 1..$c
			docker_container "chef/ubuntu-#{version}-#{i}" do
				detach true
				container_name "#{node['ubuntu']['name']}_#{i}"
				image "chef/ubuntu-#{version}"
				port "500#{i}:500#{i}"
				env 'SETTINGS_FLAVOR=local'
				volume "/mnt/docker:/docker-storage"
				command "/bin/sh /docker-storage/init_container.sh ubuntu_container_#{i} gslab /docker-storage/ubuntu_container_#{i}.json"
			end
		end
	end
end

# For debian
if node['debian']['yes_no'] == 'YES'
	$name = node['debian']['name']
	node['debian']['version'].each do |version, count|
		$c = count
		for i in 1..$c
			docker_container "chef/debian-#{version}-#{i}" do
				detach true
				container_name "#{node['debian']['name']}_#{i}"
				image "chef/debian-#{version}"
				port "510#{i}:510#{i}"
				env 'SETTINGS_FLAVOR=local'
				volume "/mnt/docker:/docker-storage"
				command "/bin/sh /docker-storage/init_container.sh debian_container_#{i} gslab /docker-storage/debian_container_#{i}.json"
			end
		end
	end
end
