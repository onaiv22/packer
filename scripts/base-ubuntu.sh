#!/bin/bash -eux

## Export the root home
export HOME=/root
export DEBIAN_FRONTEND=noninteractive

# wait for cloud-init to finish
while [ ! -f /var/lib/cloud/instance/boot-finished ]
do
  echo "$(date -Is) waiting for cloud-init to finish..."
  sleep 2
done

## Update base o/s
apt-get -y update

## Install pre-requisites
apt-get -y install software-properties-common
apt-get -y install jq
apt-get -y install update-notifier-common
apt-get -y install python3
apt-get -y install python3-dev
apt-get -y install python3-pip
apt-get -y install openjdk-8-jdk

pip3 install --upgrade botocore
pip3 install --upgrade boto3
pip3 install --upgrade ansible==2.7.10
pip3 install --upgrade cryptography
pip3 install --upgrade awscli==1.16.169
