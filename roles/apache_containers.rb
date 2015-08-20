name "apache_containers"
description "Installs and configure docker containers with apache on it."
run_list "recipe[mydocker::install]", "recipe[mydocker::launch_containers]"
override_attributes({
	"ubuntu" => {
	"yes_no" => "YES",
	"name" => "ubuntu_container",
	"version" => {
		"14.04" => 2
		}
	},
	"server_ip" => "172.20.75.189",
	"server_url" => "chefserver.example.com",
	"server_user_name" => "chef-server",
	"server_password" => "server123",
	"knife_bootstrap" => "YES"
})
