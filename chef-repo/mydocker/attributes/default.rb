default.centos = {
	"yes_no" => "NO",
	"name" => "centos_container",
	"version" => {
		#"7" => 1,
		#"6" => 1
	}
}

default.ubuntu = {
	"yes_no" => "NO",
	"name" => "ubuntu_container",
	"version" => {
		#"14.04" => 1,
		#"12.04" => 1
	}
}

default.debian = {
	"yes_no" => "NO",
	"name" => "debian_container",
	"version" => {
		#"6" => 1,
		#"7" => 1
	}
}

default["server_ip"] = "172.20.75.189"
default["server_url"] = "chefserver.example.com"
default["server_user_name"] = "chef-server"
default["server_password"] = "server123"
default["knife_bootstrap"] = "YES"

