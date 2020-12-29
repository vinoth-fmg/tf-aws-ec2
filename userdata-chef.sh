#!/bin/bash

#Install wget and download chef validator pem file
sudo yum install wget -y
sudo mkdir -p /etc/chef
sudo wget https://chefpem.s3.amazonaws.com/devops-validator.pem --output-document /etc/chef/devops-validator.pem
sudo cd /etc/chef/

# Install chef
sudo curl -L https://omnitruck.chef.io/install.sh | bash || error_exit 'could not install chef'

NODE_NAME="nodenew2"

# Create client.rb
sudo echo "log_location  STDOUT
chef_server_url         'https://172.31.27.132/organizations/devops'
validation_client_name  'devops-validator'
validation_key          '/etc/chef/devops-validator.pem'
node_name               "${NODE_NAME}"
ssl_verify_mode          :verify_none
chef_license             'accept' " > /etc/chef/client.rb
    


# Create first-boot.json
sudo echo '{
   "run_list" :[
   "recipe[devopsdemo]"
   ]
}'  > /etc/chef/first-boot.json

sudo chef-client -j /etc/chef/first-boot.json
