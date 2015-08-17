if [ $# -ne 1 ]; then
echo "usage first argument as <server-FQDN>"
exit
else

sudo apt-get -y update


sudo apt-get install -y openssh-server openssh-client


which chef-server-ctl  > /dev/null
check2=$?
if [ $check2 -eq '0' ]; then
    echo "chef-server is present"
else
wget https://web-dl.packagecloud.io/chef/stable/packages/ubuntu/trusty/chef-server-core_12.1.2-1_amd64.deb
sudo dpkg -i chef-server-core_*.deb
fi


sudo chef-server-ctl reconfigure

sudo touch /etc/opscode/chef-server.rb
sudo chmod 777 /etc/opscode/chef-server.rb
sudo echo "server_name = '$1'" >> /etc/opscode/chef-server.rb
sudo echo "api_fqdn server_name" >> /etc/opscode/chef-server.rb
sudo echo "bookshelf['vip'] = server_name" >> /etc/opscode/chef-server.rb
sudo echo "nginx['url'] = 'https://#{server_name}'" >> /etc/opscode/chef-server.rb
sudo echo "nginx['server_name'] = server_name" >> /etc/opscode/chef-server.rb
sudo echo "nginx['ssl_certificate'] = '/var/opt/opscode/nginx/ca/#{server_name}.crt'"  >> /etc/opscode/chef-server.rb
sudo echo "nginx['ssl_certificate_key'] = '/var/opt/opscode/nginx/ca/#{server_name}.key'"  >> /etc/opscode/chef-server.rb
sudo echo "lb['fqdn'] = server_name"  >> /etc/opscode/chef-server.rb
sudo chef-server-ctl reconfigure

sudo chef-server-ctl install opscode-manage
sudo chef-server-ctl reconfigure
sudo opscode-manage-ctl reconfigure

sudo chef-server-ctl install opscode-reporting
sudo chef-server-ctl reconfigure
sudo opscode-reporting-ctl reconfigure


sudo mkdir .chef
sudo chef-server-ctl user-create default default default default@example.com default123 --filename ~/.chef/default.pem
sudo chef-server-ctl org-create default_org default_org --association_user default --filename ~/.chef/default_org.pem
sudo mkdir /home/`logname`/pem
sudo cp ~/.chef/default_org.pem /home/`logname`/pem

which chef-server-ctl  > /dev/null
check3=$?
if [ $check3 -eq '0' ]; then
sudo echo "server installed successfully version is---"
#it will give chef server version
sudo head -n1 /opt/opscode/version-manifest.txt
echo "open browser and enter server URL or IP"
echo " username is 'default'"
echo " password is 'default123'"
else
echo "one or more errors check stack trace"
fi
fi
