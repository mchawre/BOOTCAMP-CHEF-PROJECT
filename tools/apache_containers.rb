name "apache_containers"
description "Installs and configure docker containers with apache on it."
run_list "recipe[mydocker::init]"
override_attributes({
	"centos" => {
	"yes_no" => "NO",
	"name" => "centos_container",
	"version" => {
		"7" => 1,
		"6" => 1
		}
	},
	"ubuntu" => {
	"yes_no" => "YES",
	"name" => "ubuntu_container",
	"version" => {
		"14.04" => 1,
		"12.04" => 0
		}
	},
	"debian" => {
	"yes_no" => "NO",
	"name" => "debian_container",
	"version" => {
		"6" => 1,
		"7" => 1
		}
	},
	"server_ip" => "172.20.75.189",
	"server_url" => "chefserver.example.com",
	"server_user_name" => "chef-server",
	"server_password" => "server123"
})
