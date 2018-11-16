#!/bin/bash
set -x

GCP_FILESTORE_IP=$1
ETH_GATEWAY=$2

ETH_DEV=$(ifconfig | grep -B1 "$(echo "${ETH_GATEWAY}" | awk -F. '{print $1 "." $2 "." $3}')" | grep eth | awk -F: '{print $1}')

# change BOOTPROTO from default none to dhcp on 2nd NIC
sed -i 's/BOOTPROTO=none/BOOTPROTO="dhcp"/' /etc/sysconfig/network-scripts/ifcfg-"${ETH_DEV}"

# create static route file for 2nd NIC
echo "${GCP_FILESTORE_IP} via ${ETH_GATEWAY} dev ${ETH_DEV}" > /etc/sysconfig/network-scripts/route-"${ETH_DEV}"
chmod 644 /etc/sysconfig/network-scripts/route-"${ETH_DEV}"


systemctl restart network
