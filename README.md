# AUTOMATION OF DOCKER USING CHEF

PURPOSE :
---------
Automate the process of docker installation and chef setup. Also, provide readily available containers with preconfigured state.


Further, we are providing steps to set up chef set up and method to start with our proposed system.

PRE-CONFIGURATION :
 
 Before going further, make sure that you have following configuration with you.

 Server machine, workstation machine and nodes all should be communicate each other.

 chef-server requires following hardware-configuration
    4 GB RAM
    64 bit Operating System running on machine
    Sufficient amount of hard drive space (preferably 20 Gb).
    4 CPU Cores
  
setting up workstation
    workstation requires following hardware-configuration
    1 GB RAM
    64 bit Operating System running on machine
    Sufficient amount of hard drive space.


get the node having following hardware configuration
   1 GB RAM
   64 bit Operating System running on machine
   Sufficient amount of hard drive space.


I) Setting up chef :

STEP 1: Go to your server node and run the following script:
  tools/auto_server.sh
  This script will install chef-server on your node and creates user with name "default" and associated organisation    as "default_org"
  
  Verify this by using browser. Enter server IP and enter user name and password on the opened window.

STEP 2: Go to workstation node and run following script:
  tools/auto_workstation.sh
  This script will connect your workstation with installed server.
  
STEP 3:    At this point you have two options to set up node.
   1) by using knife bootstrap command from workstation as
           knife bootstrap {{address}} --ssh-user {{user}} --ssh-password '{{password}}' --sudo --use-sudo-password --node-name node1 --run-list 'recipe[learn_chef_httpd]'
           
   2) by running tools/auto_node.sh script.
          
Now you have your chef setup ready. Further we are going to install docker and creating containers as per user need.
II) 
STEP 1: Go to your workstation node and upload all the recipes on the server. The needed recipes are provided in the directory chef-repo/dependencies. After that upload apache and mydocker cookbook.

Command is 
$ knife upload [COOKBOOK NAME]

STEP 2: Upload role  roles/apache_containers.rb on server.
STEP 3: from workstation run following command-
         knife bootstrap {{address}} --ssh-user {{user}} --ssh-password '{{password}}' --sudo --use-sudo-password --node-name node1 --run-list 'role['apache_containers']'

Note :- You can edit role as per your need.



