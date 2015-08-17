#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "apache2"

service "apache2" do
	supports :status => true
	action [:enable, :start]
end
