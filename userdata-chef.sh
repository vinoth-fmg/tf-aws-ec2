#!/bin/bash

#Install wget and download chef validator pem file
sudo yum install wget -y
sudo mkdir -p /etc/chef
sudo wget https://chefpem.s3.amazonaws.com/devops-validator.pem --output-document /etc/chef/devops-validator.pem
sudo cd /etc/chef/

# Install chef
sudo curl -L https://omnitruck.chef.io/install.sh | bash || error_exit 'could not install chef'

NODE_NAME="node-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 4 | head -n 1)"

# Create client.rb
sudo cat > "/etc/chef/client.rb" << EOF
log_location            STDOUT
chef_server_url         'https://172.31.27.132/organizations/devops'
validation_client_name  'devops-validator'
validation_key          '/etc/chef/devops-validator.pem'
node_name               "${NODE_NAME}"
ssl_verify_mode          :verify_none
chef_license             'accept'
EOF


# Create first-boot.json
sudo cat > "/etc/chef/first-boot.json" << EOF
{
   "run_list" :[
   "recipe[devopsdemo]"
   ]
}
EOF
sudo chef-client -j /etc/chef/first-boot.json
