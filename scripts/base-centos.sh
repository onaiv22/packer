#!/bin/bash -eux

# wait for cloud-init to finish
while [ ! -f /var/lib/cloud/instance/boot-finished ]
do
  echo "$(date -Is) waiting for cloud-init to finish..."
  sleep 2
done

yum update -y

## Install pre-requisites
yum -y install epel-release
yum -y install jq
yum -y install python-pip

# Ensure compatible Python packages
yum -y install python-urllib3
yum -y install python-requests

pip install --upgrade pip
pip install --upgrade botocore==1.12.159
pip install --upgrade boto
pip install --upgrade boto3
pip install --upgrade setuptools
pip install --upgrade ansible==2.7.10
pip install --upgrade cryptography
pip install --upgrade awscli


