#
# Cookbook Name:: mydocker
# Recipe:: run_containers
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

if  node['knife_bootstrap'] == 'YES'
	remote_directory '/mnt/docker' do
		mode '0777'
		action :create
	end
end

# Script file is uploaded on node
cookbook_file '/mnt/docker/init_container.sh' do
  source 'init_container.sh'
  mode '0777'
  action :create
end

ip = node["server_ip"]
url = node["server_url"]
user = node["server_user_name"]
password = node["server_password"] 

# For centos
if node['centos']['yes_no'] == 'YES'
	n = node['centos']['name']
	j = -2
	node['centos']['version'].each do |version, count|
		$c = count
		j += 2
		for i in 1..$c
			docker_container "chef/centos-#{version}-#{i}" do
		        	detach true
		        	container_name "#{node['centos']['name']}_v#{version}_#{i}"
				image "chef/centos-#{version}"
				port "80"
				env 'SETTINGS_FLAVOR=local'
				volume "/mnt/docker:/docker-storage"
				command "/bin/sh /docker-storage/init_container.sh #{n}_v#{version}_#{i} gslab /docker-storage/#{n}_v#{version}_#{i}.json #{ip} #{url} #{user} #{password}"
			end
		end
	end
end

# For ubuntu
if node['ubuntu']['yes_no'] == 'YES'
	n = node['ubuntu']['name']
	j = -2
	node['ubuntu']['version'].each do |version, count|
		$c = count
		j += 2
		for i in 1..$c
			docker_container "chef/ubuntu-#{version}-#{i}" do
				detach true
				container_name "#{node['ubuntu']['name']}_v#{version}_#{i}"
				image "chef/ubuntu-#{version}"
				port "80"
				env 'SETTINGS_FLAVOR=local'
				volume "/mnt/docker:/docker-storage"
				command "/bin/sh /docker-storage/init_container.sh #{n}_v#{version}_#{i} gslab /docker-storage/#{n}_v#{version}_#{i}.json #{ip} #{url} #{user} #{password}"
			end
		end
	end
end

# For debian
if node['debian']['yes_no'] == 'YES'
	n = node['debian']['name']
	j = -2
	node['debian']['version'].each do |version, count|
		$c = count
		j += 2
		for i in 1..$c
			docker_container "chef/debian-#{version}-#{i}" do
				detach true
				container_name "#{node['debian']['name']}_v#{version}_#{i}"
				image "chef/debian-#{version}"
				port "80"
				env 'SETTINGS_FLAVOR=local'
				volume "/mnt/docker:/docker-storage"
				command "/bin/sh /docker-storage/init_container.sh #{n}_v#{version}_#{i} gslab /docker-storage/#{n}_v#{version}_#{i}.json #{ip} #{url} #{user} #{password}"
			end
		end
	end
end
