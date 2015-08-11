#default['centos']['yes_no'] = 'YES'
#default['ubuntu']['yes_no'] = 'YES'
#default['debian']['yes_no'] = 'YES'
#default['centos']['version'] = '6'
#default['centos']['count'] = '2'
#default['centos']['version'] = {'7' => 1, '6' => 1}
#default['centos']['name'] = 'centos_container'
#default['centos']['count'] = [1, 1]
#default['ubuntu']['version'] = {'14.04' => 1, '12.04' => 1}
#default['ubuntu']['name'] = 'ubuntu_container'
#default['ubuntu']['count'] = [1, 1]
#default['ubuntu']['version'] = '12.04'
#default['ubuntu']['count'] = '2'
#default['debian']['version'] = {'6' => 1,'7' => 1}
#default['debian']['name'] = 'debian_container'
#default['debian']['count'] = [2, 1]
#default['debian']['version'] = '7'
#default['debian']['count'] = '2'

default.centos = {
	"yes_no" => "NO",
	"name" => "centos_container",
	"version" => {
		"7" => 1,
		"6" => 1
	}
}

default.ubuntu = {
	"yes_no" => "YES",
	"name" => "ubuntu_container",
	"version" => {
		"14.04" => 1,
		"12.04" => 1
	}
}

default.debian = {
	"yes_no" => "YES",
	"name" => "debian_container",
	"version" => {
		"6" => 1,
		"7" => 1
	}
}

