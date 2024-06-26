#!/bin/bash

#This is My assignment 1 about System Report


USERNAME=$(whoami) # The command to get the current username


DATEANDTIME=$(date) # The command to get the current date and time

# Generating the system report
echo "System Report generated by $USERNAME,$DATEANDTIME"
echo ""
echo "System Information"
echo "------------------"

HOSTNAME=$(hostname) # This is the line of command to get the hostname
echo "Hostname: $HOSTNAME"

#The following command is to display the OS and it's version

OSName=$(uname -s)    # This line of command is to print the operating system name

OSVersion=$(lsb_release -d | grep Description | awk '{print $2, $3, $4}')    # This command is to print the operating system version
echo "OS: $OSName $OSVersion"

UPTIME=$(uptime ) #The line of command to get the System Uptime
echo "Uptime: $UPTIME"


echo ""

#This following command is to get the information abou CPU model and processor
echo "Hardware Information"
echo "--------------------"

CPUVendor=$(lscpu | grep "Vendor ID:" | awk '{print $3}') #Ths line of command is to display cpu processor and vendor
echo "cpuprocessor: $CPUVendor"

CPUMODEL=$(lscpu | grep "Model name:" | awk -F': ' '{print $2}') #This line of command is to display model of the CPU
echo "cpumodel: $CPUMODEL"

CPUCURRENTSPEED=$(cat /proc/cpuinfo | grep -m 1 "cpu MHz") #Getting current CPU speed (in MHz)
echo "$CPUCURRENTSPEED"

CPUMAXSPEED=$(sudo dmidecode -t processor | grep -m 1 "Max Speed") # Geting maximum CPU speed (in MHz)
echo "$CPUMAXSPEED"

RAMSIZE=$(cat /proc/meminfo | grep MemTotal) #This command is used for calculating RAM Size.
echo "$RAMSIZE"

Disks=$(lsblk -o NAME,MODEL,SIZE | grep '^sd') #This command is to figure out disks name,size and its model.
echo "Disks Info is: $Disks"


VIDEOCARD=$( lspci | grep -i vga) #This command displays the vidoecard model and manufacturer of the video card.
echo "video card is: $VIDEOCARD"

echo ""
echo ""

echo "Network Information"
echo "------------------"

FQDN=$(hostname --fqdn) #Ths command is to find the fully qualified domain of the system.
echo "FQDN is:- $FQDN"

HOSTADDRESS=$(hostname -I | awk '{print $1'} ) #This line of code displays host ip address of the machine.
echo "Host address is: $HOSTADDRESS"

GATEWAYIP=$(ip route | grep default | awk '{print $3}') #This code determines the default gateway ip addresss
echo "Gateway ip is: $GATEWAYIP"

DNSSERVERIP=$(cat /etc/resolv.conf | grep 'nameserver' | awk '{print $2}') #This line of Code finds out the DNS server IP address.
echo "DNS Server IP is: $DNSSERVERIP"


echo ""

INTERFACENAME=$(lspci | grep -i ethernet) #This command helps us to find the make and model for network card.
echo "Interface Name:- $INTERFACENAME" 

IPINCIDR=$(ip -o -f inet addr show | awk '{print $4}') #This line of code extracts the information of ip address in CIDR format.
echo "Ip address in CIDR format is:- $IPINCIDR"


echo ""

echo "System Status"
echo "-------------"

USERSLOGGEDIN=$(users) # This line of command helps to find the list of users logged in the system.
echo "The list of users loggd in is:- $USERSLOGGEDIN"

DISKSPACE=$(df -h --output=source,avail | grep -v '^Filesystem') #This line of code determines the free disk space available in the system.
echo "Free disk space are:- $DISKSPACE"

PROCESSCOUNT=$( ps -ef | wc -l) #This line of command counts the total process used in the system.
echo "The totalprocess count is:- $PROCESSCOUNT"

LOADAVERAGE=$(uptime | awk -F 'load average: ' '{print $2}') #Ths line of command calculates the load avearge using uptime command.
echo "The Load averages are:- $LOADAVERAGE"

MEMORYALLOCATION=$(free | awk '/^Mem:/ {print $4}') #This line of code finds the free memory in the system.
echo "The free memory in the system is:- $MEMORYALLOCATION"

PORTSLISTENING=$( sudo netstat -tunlp|grep LISTEN | awk '/^(tcp|udp)/ {print $4}' | awk -F: '{print $NF}') #This line of command lists all the active listening ports.
echo "The numbers of ports listening are:- $PORTSLISTENING"

UFWRULES=$(sudo ufw status) #This line of Command helps us to recognize the status of the firewall.
echo "The UFW $UFWRULES"




