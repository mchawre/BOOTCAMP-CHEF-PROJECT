if [ $# -ne 7 ]; then
echo "usage first argument as <node-name>, second argument as <organization name> and third argument as <name of json file>"
echo "4th <server IP>, 5th <server's FQDN>, 6th <server's user name> 7th <server's password>"
exit
else
if [ -f /etc/debian_version ]; then
echo "Platform : ubuntu or debian"
sudo echo "`logname` ALL=(ALL) NOPASSWD: ALL"  >> /etc/sudoers
sudo apt-get -y update
sudo mkdir /etc/chef
sudo touch /etc/chef/client.rb
sudo chmod 777 /etc/chef/client.rb
sudo echo "$4    $5      $6"  >> /etc/hosts
sudo echo "current_dir = File.dirname(__FILE__)" >> /etc/chef/client.rb
sudo echo "log_level        :info" >> /etc/chef/client.rb
sudo echo "chef_server_url  'https://$5/organizations/$2'" >> /etc/chef/client.rb
sudo echo "node_name                '$1'" >> /etc/chef/client.rb
sudo echo "validation_client_name   '$2-validator'" >> /etc/chef/client.rb
sudo echo "ssl_verify_mode    :verify_none" >> /etc/chef/client.rb
apt-get install -y openssh-server openssh-client
apt-get install -y curl
curl -L https://www.opscode.com/chef/install.sh | bash
sudo sshpass -p $7 scp -o StrictHostKeyChecking=no $6@$4:/home/$6/pem/$2-validator.pem /etc/chef
sudo chef-client -S https://$5/organizations/$2 -K /etc/chef/$2-validator.pem -j $3


elif [ -f /etc/redhat-release ]; then
echo "Platform : centos or fedora or redhat"
mkdir /etc/chef
touch /etc/chef/client.rb
echo "$4    $5      $6"  >> /etc/hosts
echo "current_dir = File.dirname(__FILE__)" >> /etc/chef/client.rb
echo "log_level        :info" >> /etc/chef/client.rb
echo "chef_server_url  'https://$5/organizations/$2'" >> /etc/chef/client.rb
echo "node_name                '$1'" >> /etc/chef/client.rb
echo "validation_client_name   '$2-validator'" >> /etc/chef/client.rb
echo "ssl_verify_mode    :verify_none" >> /etc/chef/client.rb
yum -y update
yum install -y openssh-server openssh-client openssh-clients
yum install -y curl
curl -L https://www.opscode.com/chef/install.sh | bash
yum install -y wget
wget http://epel.mirror.net.in/epel/6/i386/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
yum install -y sshpass
sshpass -p $7 scp -o StrictHostKeyChecking=no $6@$4:/home/$6/pem/$2-validator.pem /etc/chef
chef-client -S https://$5/organizations/$2 -K /etc/chef/$2-validator.pem -j $3
fi
fi
