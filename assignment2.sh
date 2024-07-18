#!/bin/bash

#This is my Script  for Assignment Two

# The following part of my code depicts the Network Configuration.

# The given code modifies netplan configuration with correct permissions
sudo tee /etc/netplan/00-installer-config.yaml > /dev/null <<EOT
network:
  version: 2
  ethernets:
    ens0:
      addresses: [192.168.16.21/24]
      nameservers:
        addresses: [192.168.16.2]
EOT

# Applying netplan configuration
sudo netplan apply

# The below code is Updating the /etc/hosts for correct configuration
sudo bash -c 'echo "192.168.16.21 server1" > /etc/hosts'

# The following lines of code is Installing Required Software and packages
sudo apt update
sudo apt install -y apache2 squid

#The following line of codes demonstrates the firewall implementation and enabling it using ufw rules.
sudo apt update   #Updating of the system.

sudo apt install ufw    # Installing UFW for the firewall.

sudo ufw --force reset   # This line of code resets UFW to default.

sudo ufw allow ssh #  This code Allow SSH connections

sudo ufw allow http    #This line od code allows HTTP connections.

sudo ufw allow from 192.168.16.0/24 to any port 22   #This line of code is allowing SSH connections from  specified subnet.

sudo ufw allow 3128  # This line of code allows connects on port 3128.

sudo ufw --force enable #This code is enabling the firewall.

# The following code is Creating Users according to the instructions.

users="dennis aubrey captain snibbles brownie scooter sandy perrier cindy tiger yoda"

for user in $users;  #
do
    #  This line of code is Creating user within home directory and bash as default shell
    sudo useradd -m -s /bin/bash "$user"

    #  The following code is Generating SSH keys and setting up authorized keys.
    sudo -u "$user" bash -c '
        mkdir -p ~/.ssh
        ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
        ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
        cat ~/.ssh/*.pub > ~/.ssh/authorized_keys
        chmod 700 ~/.ssh
        chmod 600 ~/.ssh/authorized_keys
    '

    echo "Created user: $user"
done


sudo usermod -aG sudo dennis  # This code is Adding Special configuration for the user dennis
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG4rT3vTt99Ox5kndS4HmgTrKBT8SKzhK4rhGkEVGlCI student@generic-vm" | sudo tee -a /home/dennis/.ssh/authorized_keys

echo " Here we go !! Finally User is created and configuration is completed."

