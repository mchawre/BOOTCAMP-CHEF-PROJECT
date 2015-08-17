if [ $# -ne 3 ]; then
echo "usage first argument as <node-name>, second argument as <organization name> and third argument as <name of json file>"
exit
else
if [ -f /etc/debian_version ]; then
echo "ubuntu or debian"
#apt-get -y update
mkdir /etc/chef
mkdir /etc/chef/trusted_certs
touch /etc/chef/client.rb
echo "172.20.75.189    chefserver.example.com      chefserver"  >> /etc/hosts
echo "current_dir = File.dirname(__FILE__)" >> /etc/chef/client.rb
echo "log_level        :info" >> /etc/chef/client.rb
echo "chef_server_url  'https://chefserver.example.com/organizations/$2'" >> /etc/chef/client.rb
echo "node_name                '$1'" >> /etc/chef/client.rb
echo "validation_client_name   '$2-validator'" >> /etc/chef/client.rb
echo "ssl_verify_mode    :verify_none" >> /etc/chef/client.rb
apt-get install -y openssh-server openssh-client
apt-get install -y sshpass 
#curl -L https://www.opscode.com/chef/install.sh | bash
sshpass -p server123 scp -o StrictHostKeyChecking=no chef-server@172.20.75.189:/home/chef-server/pem/$2-validator.pem /etc/chef
chef-client -S https://chefserver.example.com/organizations/$2 -K /etc/chef/$2-validator.pem
mkdir /etc/chef/secure
cp /etc/chef/client.pem /etc/chef/secure/
cp $3 /etc/chef/first-boot.json
chef-init --onboot

elif [ -f /etc/redhat-release ]; then
echo "centos or fedora or redhat"
mkdir /etc/chef
mkdir /etc/chef/trusted_certs
touch /etc/chef/client.rb
echo "172.20.75.189    chefserver.example.com      chefserver"  >> /etc/hosts
echo "current_dir = File.dirname(__FILE__)" >> /etc/chef/client.rb
echo "log_level        :info" >> /etc/chef/client.rb
echo "chef_server_url  'https://chefserver.example.com/organizations/$2'" >> /etc/chef/client.rb
echo "node_name                '$1'" >> /etc/chef/client.rb
echo "validation_client_name   '$2-validator'" >> /etc/chef/client.rb
echo "ssl_verify_mode    :verify_none" >> /etc/chef/client.rb
#yum -y update
yum install -y openssh-server openssh-client openssh-clients
yum install -y wget
wget http://epel.mirror.net.in/epel/6/i386/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
yum install -y sshpass
#curl -L https://www.opscode.com/chef/install.sh | bash
sshpass -p server123 scp -o StrictHostKeyChecking=no chef-server@172.20.75.189:/home/chef-server/pem/$2-validator.pem /etc/chef
chef-client -S https://chefserver.example.com/organizations/$2 -K /etc/chef/$2-validator.pem
mkdir /etc/chef/secure
cp /etc/chef/client.pem /etc/chef/secure/
cp $3 /etc/chef/first-boot.json
chef-init --onboot
fi
fi

