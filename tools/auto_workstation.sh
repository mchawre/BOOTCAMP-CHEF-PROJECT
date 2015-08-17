if [ $# -ne 3 ]; then
echo "usage first argument as <server-IP>, second argument as <server-FQDN> and third argument as <server-hostname>"
exit
else
sudo apt-get -y update


sudo apt-get install -y openssh-server openssh-client


which chef > /dev/null
check2=$?
if [ $check2 -eq '0' ]; then
    echo "chef-dk is already present"
else
wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.6.2-1_amd64.deb
sudo dpkg -i chefdk_*.deb
fi

sudo chef verify
sudo chef generate repo chef-repo
sudo mkdir ~/chef-repo/.chef
sudo scp $3@$1:~/pem/*.pem ~/chef-repo/.chef
sudo scp workstation1@192.168.1.26:/home/workstation1/chef-repo/.chef/*.pem ~/chef-repo/.chef
sudo touch ~/chef-repo/.chef/knife.rb
sudo chmod 777 ~/chef-repo/.chef/knife.rb
echo "log_level                :info" >>  ~/chef-repo/.chef/knife.rb
echo "log_location             STDOUT"  >>  ~/chef-repo/.chef/knife.rb
echo "node_name                'default'"  >>  ~/chef-repo/.chef/knife.rb
echo "client_key               '~/chef-repo/.chef/default.pem'"  >>  ~/chef-repo/.chef/knife.rb
echo "validation_client_name   'default_org-validator'" >>  ~/chef-repo/.chef/knife.rb
echo "validation_key           '~/chef-repo/.chef/default_org-validator.pem'"  >>  ~/chef-repo/.chef/knife.rb
echo "chef_server_url          'https://$2/organizations/default_org'"  >>  ~/chef-repo/.chef/knife.rb
echo "syntax_check_cache_path  '~/chef-repo/.chef/syntax_check_cache'"  >>  ~/chef-repo/.chef/knife.rb
echo "cookbook_path [ '~/chef-repo/cookbooks' ]"  >>  ~/chef-repo/.chef/knife.rb
cd ~/chef-repo
sudo knife ssl fetch
sudo knife ssl check
sudo knife client list
fi
